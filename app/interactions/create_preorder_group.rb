# frozen_string_literal: true

class CreatePreorderGroup < ActiveInteraction::Base
  # Params will look like this:
  # {
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

  interface :group, methods: %i[persisted?], default: -> { PreorderReservationGroup.new }

  validate do
    if params[:turns].present? && turn_ids.blank?
      errors.add(:params, "turns are provided but blank: #{turn_ids}")
    end
  end

  def execute
    PreorderReservationGroup.transaction do
      @group = group
      create_group if valid?
      create_dates if errors.empty?
      create_turns if errors.empty?

      raise ActiveRecord::Rollback if errors.any?
    end

    unless params.blank?
      Rails.logger.warn("expected params to be blank at this point, got #{params.inspect}")
    end

    @group
  end

  def create_group
    @group.assign_attributes(
      {
        title: params.delete(:title),
        preorder_type: params.delete(:preorder_type),
        payment_value: params.delete(:payment_value),
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
end
