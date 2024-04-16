# frozen_string_literal: true

# Filter ReservationTurn records
class SearchReservationTurns < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    items = ReservationTurn.all

    items = filter_by_date(items)

    items = items.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?

    items
  end

  def filter_by_date(items)
    return items.where(weekday: Date.parse(params[:date]).wday) if params[:date].present?

    items
  rescue Date::Error
    items
  end
end
