# frozen_string_literal: true

# Given a date, will return an array of times that are available for that ReservationTurn.
class ReservationTurnValidTimes < ActiveInteraction::Base
  record :turn, class: 'ReservationTurn'
  string :format, default: '%H:%M'

  def execute
    starts_at = turn.starts_at
    ends_at = turn.ends_at
    times = []

    while starts_at <= ends_at
      times << (format.nil? ? starts_at : starts_at.strftime(format))

      starts_at += turn.step.minutes
    end

    times
  end
end
