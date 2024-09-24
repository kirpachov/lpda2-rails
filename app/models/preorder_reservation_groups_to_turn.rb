# frozen_string_literal: true

# Jointable between PreorderReservationGroup and ReservationTurn
class PreorderReservationGroupsToTurn < ApplicationRecord
  belongs_to :reservation_turn
  belongs_to :preorder_reservation_group
end
