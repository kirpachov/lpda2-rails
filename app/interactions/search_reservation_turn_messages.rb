# frozen_string_literal: true

class SearchReservationTurnMessages < ActiveInteraction::Base
  interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

  def execute
    ReservationTurnMessage.all
  end
end
