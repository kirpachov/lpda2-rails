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
  #   turns: [<ReservationTurn#id>]
  # }
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  validate do
    if params[:id].blank?
      errors.add(:params, "id is blank")
    end

    if group.nil?
      errors.add(:params, "group not found")
    end
  end

  def execute
    PreorderReservationGroup.transaction do
      # group = group
      update_group if valid?
      update_dates if errors.empty?
      update_turns if errors.empty?

      raise ActiveRecord::Rollback if errors.any?
    end

    unless params.blank?
      Rails.logger.warn("expected params to be blank at this point, got #{params.inspect}")
    end

    group
  end

  def update_group
    data = (params.keys.map(&:to_sym) & %i[title preorder_type payment_value active_from active_to status]).map { |k| [k, params.delete(k)] }.to_h
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

    call = CreatePreorderDates.run(group: group, params: { dates: dates })
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
end
