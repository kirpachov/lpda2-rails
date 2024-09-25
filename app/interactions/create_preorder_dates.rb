# frozen_string_literal: true

class CreatePreorderDates < ActiveInteraction::Base
  # Params will look like this:
  # {
  #   dates: [
  #     { turn_id: 2, date: "2024-02-14" },
  #     { turn_id: 1, date: "2024-02-14" },
  #   ]
  # }
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  record :group, class: PreorderReservationGroup

  validates :group, presence: true

  validate do
    unless params.present? && params[:dates].is_a?(Array) && params[:dates].all?{|i| i.is_a?(Hash)}
      errors.add(:base, "expected params[:dates] to be a array of hashes but params is #{params.inspect}")
    end
  end

  def execute
    params.delete(:dates).map do |datum|
      date = PreorderReservationDate.new(
        datum.symbolize_keys.slice(:date).merge(group_id: group.id, reservation_turn_id: datum[:turn_id] || datum[:reservation_turn_id])
      )

      unless date.valid? && date.save
        errors.add(:base, "date #{datum.inspect} is not valid: #{date.errors.full_messages.join(', ')}")
      end
    end
  end
end
