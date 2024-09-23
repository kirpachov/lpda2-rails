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
  #   ]
  # }
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    PreorderReservationGroup.transaction do
      create_group if valid?
      create_dates if errors.empty?

      raise ActiveRecord::Rollback if errors.any?
    end

    unless params.blank?
      Rails.logger.warn("expected params to be blank at this point, got #{params.inspect}")
    end

    @group
  end

  def create_group
    @group = PreorderReservationGroup.new(
      title: params.delete(:title),
      preorder_type: params.delete(:preorder_type),
      payment_value: params.delete(:payment_value),
      active_from: params.delete(:active_from),
      active_to: params.delete(:active_to),
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
    # @dates = params.delete(:dates).map do |datum|
    #   date = PreorderReservationDate.new(datum.symbolize_keys.slice(:turn_id, :date).merge(group_id: @group.id))

    #   unless date.valid? && date.save
    #     errors.add(:base, "date #{datum.inspect} is not valid: #{date.errors.full_messages.join(', ')}")
    #   end
    # end
    call = CreatePreorderDates.run(group: @group, params: { dates: params.delete(:dates) })
    errors.merge!(call.errors)
    @dates = call.result
  end
end
