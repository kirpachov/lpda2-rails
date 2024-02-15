# frozen_string_literal: true

class TagInReservation < ApplicationRecord
  # ################################
  # Associations
  # ################################
  # belongs_to :reservation_tag, inverse_of: :tags_in_reservations, counter_cache: :reservations_count
  belongs_to :reservation_tag, inverse_of: :tags_in_reservations, class_name: 'ReservationTag'
  belongs_to :reservation, class_name: 'Reservation'

  # ################################
  # Validations
  # ################################
  validates_uniqueness_of :reservation_id, scope: :reservation_tag_id
end
