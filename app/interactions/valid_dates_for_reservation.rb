# frozen_string_literal: true

class ValidDatesForReservation < ActiveInteraction::Base
  interface :params, methods: %i[[] each]

  def execute
    from_date = params[:from_date].present? ? Date.parse(params[:from_date].to_s) : Time.zone.now.to_date
    to_date = params[:to_date].present? ? Date.parse(params[:to_date].to_s) : (Time.zone.now.to_date + 30.days)

    # If from_date is in the past, set it to today
    from_date = Time.zone.now.to_date if from_date < Time.zone.now.to_date

    if Setting.where(key: :reservation_max_days_in_advance).first.present? && (to_date > Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days)
      to_date = Time.zone.now.to_date + Setting.where(key: :reservation_max_days_in_advance).first.value.to_i.days
    end

    dates = []

    while from_date <= to_date
      date = from_date
      from_date += 1.day

      items = ReservationTurn.all.where(weekday: date.wday).map do |turn|
        turn.valid_times(date: date.to_s)
      end

      dates << date.strftime("%Y-%m-%d") if items.flatten.any?
    end

    dates
  end
end
