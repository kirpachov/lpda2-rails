# frozen_string_literal: true

class ReservationTag < ApplicationRecord
  # ################################
  # Settings, Modules, enums, ...
  # ################################

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
