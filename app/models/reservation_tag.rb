# frozen_string_literal: true

class ReservationTag < ApplicationRecord
  # ################################
  # Settings, Modules, enums, ...
  # ################################

  # ################################
  # Associations
  # ################################
  has_many :tags_in_reservations, class_name: 'TagInReservation', inverse_of: :reservation_tag, dependent: :destroy
  has_many :reservations, through: :tags_in_reservations, class_name: 'Reservation'

  # ################################
  # Validators
  # ################################
  validates :title, presence: true, uniqueness: true, length: { maximum: 255, minimum: 1 }
  validates :color, presence: true, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }
  validates :bg_color, presence: true, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }

  # ################################
  # Scopes
  # ################################
  scope :visible, -> { all }
end
