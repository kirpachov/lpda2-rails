# frozen_string_literal: true

# Given a date, will return an array of times that are available for that ReservationTurn.
class ReservationTurnValidTimes < ActiveInteraction::Base
  record :turn, class: "ReservationTurn"
  string :format, default: "%H:%M"

  # When date is provided, times will be fildered to only include times that are greater than the current time.
  string :date, default: nil

  def execute
    starts_at = turn.starts_at
    ends_at = turn.ends_at
    times = []

    while starts_at <= ends_at
      times << starts_at.strftime(format)

      starts_at += turn.step.minutes
    end

    if date.present? && date.to_date == Time.zone.now.to_date
      times = times.select { |time| Time.zone.parse(time) > Time.zone.now }
    end

    times
  end
end
