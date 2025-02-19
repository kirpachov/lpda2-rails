# frozen_string_literal: true

class ValidTimesGroupByTurn < ActiveInteraction::Base
  interface :params, methods: %i[merge to_h], default: {}

  validate do
    errors.add(:date, "is missing or invalid.") if date.blank?
  end

  def execute
    ReservationTurn.visible.where(weekday: date.wday).includes(reservation_turn_messages: [:text_translations]).map do |turn|
      process_turn(turn)
    end.flatten
  end

  private

  def process_turn(turn)
    group = turn.preorder_reservation_groups.first&.active? ? turn.preorder_reservation_groups.first : nil
    turn.as_json.merge(
      valid_times: turn.valid_times(date: params[:date]),
      preorder_reservation_group: group&.as_json(methods: %i[message]),
      messages: turn.reservation_turn_messages.active_at(date).map do |m|
        m.as_json(
          only: %i[id from_date to_date],
          methods: %i[message]
        )
      end
    )
  end

  def date
    return @date if defined?(@date)
    return @date = nil if params[:date].blank?

    @date ||= Date.parse(params[:date].to_s)
  rescue Date::Error => e
    @date = nil
    errors.add(:date, e)
  end
end
