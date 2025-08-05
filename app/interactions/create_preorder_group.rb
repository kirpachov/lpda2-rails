# frozen_string_literal: true

class CreatePreorderGroup < ActiveInteraction::Base
  # Params will look like this:
  # {
  #   title: "Pagamento anticipato",
  #   preorder_type: "nexi_payment",
  #   payment_value: 30,
  #   min_people: 2,
  #   message: { it: "Le chiediamo di pagare ...", en: "We ask you to pay ..." },
  #   dates: [
  #     { turn_id: 2, date: "2024-02-14" },
  #     { turn_id: 1, date: "2024-02-14" },
  #   ],
  #   turns: [<ReservationTurn#id>]
  #   table_types: [
  #     { table_type_id: 1, people_per_turn: 2, price: 10 },
  #   ]
  # }
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate do
    errors.add(:params, "turns are provided but blank: #{turn_ids}") if params[:turns].present? && turn_ids.blank?
  end

  def execute
    PreorderReservationGroup.transaction do
      # @group = group
      create_group if valid?
      create_dates if errors.empty?
      create_turns if errors.empty?
      associate_table_types if errors.empty?

      raise ActiveRecord::Rollback if errors.any?
    end

    Rails.logger.warn("expected params to be blank at this point, got #{params.inspect}") if params.present?

    @group
  end

  def create_group
    @group = PreorderReservationGroup.new(
      {
        title: params.delete(:title),
        preorder_type: params.delete(:preorder_type),
        payment_value: params.delete(:payment_value),
        min_people: params.delete(:min_people),
        active_from: params.delete(:active_from),
        active_to: params.delete(:active_to),
        status: params.delete(:status)
      }.compact
    )

    if @group.valid? && @group.save
      # params[:message] should look like:
      # { it: "String", en: "EnglishString" }
      @group.assign_translation("message", params.delete(:message))
      @group.save
    end

    errors.merge!(@group.errors)

    @group
  end

  def create_dates
    return @dates = [] if params[:dates].blank?

    call = CreatePreorderDates.run(group: @group, params: { dates: params.delete(:dates) })
    errors.merge!(call.errors)
    @dates = call.result
  end

  def turn_ids
    return @turn_ids if defined?(@turn_ids)

    @turn_ids = [params.delete(:turns)].flatten.map { |s| s.to_s.split(",") }.flatten.map(&:to_i).filter(&:positive?)
  end

  def create_turns
    @group.turns = ReservationTurn.where(id: turn_ids)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "#{e.message} while creating turns for group")
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
