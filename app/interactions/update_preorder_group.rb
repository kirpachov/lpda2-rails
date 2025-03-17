# frozen_string_literal: true

class UpdatePreorderGroup < ActiveInteraction::Base
  # Params will look like this:
  # {
  #   id: <PreorderReservationGroup#id>,
  #   title: "Pagamento anticipato",
  #   preorder_type: "nexi_payment",
  #   payment_value: 30,
  #   message: { it: "Le chiediamo di pagare ...", en: "We ask you to pay ..." },
  #   dates: [
  #     { turn_id: 2, date: "2024-02-14" },
  #     { turn_id: 1, date: "2024-02-14" },
  #   ],
  #   turns: [<ReservationTurn#id>],
  #   table_types: [
  #     { table_type_id: 1, people_per_turn: 2, price: 10 },
  #   ]
  # }
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate do
    errors.add(:params, "id is blank") if params[:id].blank?

    errors.add(:params, "group not found") if group.nil?
  end

  def execute
    PreorderReservationGroup.transaction do
      update_group if valid?
      update_dates if errors.empty?
      update_turns if errors.empty?
      associate_table_types if errors.empty?

      raise ActiveRecord::Rollback if errors.any?
    end

    Rails.logger.warn("expected params to be blank at this point, got #{params.inspect}") if params.present?

    group
  end

  def update_group
    data = (params.keys.map(&:to_sym) & %i[title preorder_type payment_value active_from active_to
                                           status]).index_with do |k|
      params.delete(k)
    end
    group.assign_attributes(data)

    if group.valid? && group.save
      # params[:message] should look like:
      # { it: "String", en: "EnglishString" }
      group.assign_translation("message", params.delete(:message))
      group.save
    end

    errors.merge!(group.errors)

    group
  end

  def update_dates
    return [] unless params.has_key?(:dates)
    return @dates if defined?(@dates)

    dates = [params.delete(:dates)].flatten.filter(&:present?)

    call = CreatePreorderDates.run(group:, params: { dates: })
    errors.merge!(call.errors)
    @dates = call.result
  end

  def update_turns
    return true unless params.has_key?(:turns)

    turn_ids = [params.delete(:turns)].flatten.map { |s| s.to_s.split(",") }.flatten.map(&:to_i).filter(&:positive?)

    group.turns = ReservationTurn.where(id: turn_ids)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "#{e.message} while creating turns for group")
  end

  def group
    @group ||= PreorderReservationGroup.find_by(id: params[:id])
  end

  def associate_table_types
    table_types.each(&:save!)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "#{e.message} while associating table types to group")
  end

  def table_types
    @table_types ||= initialize_table_types
  end

  def initialize_table_types
    return [] unless params.has_key?(:table_types)

    table_types = [params.delete(:table_types)].flatten.filter(&:present?)

    table_types.map do |datum|
      item = TableTypeToPreorderReservationGroup.new(
        preorder_reservation_group: @group,
        table_type: TableType.active.find_by(id: datum[:table_type_id]),
        people_per_turn: datum[:people_per_turn],
        price: datum[:price]
      )

      errors.add(:base, item.errors.full_messages.join(",")) unless item.valid?

      item
    end
  end
end
