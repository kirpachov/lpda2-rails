# frozen_string_literal: true

# text to shown in the public pages to warn people about things.
class PublicMessage < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  extend Mobility
  translates :text

  KNOWN_KEYS = %w[
    home-landing
    home-about
    home-menu
    home-instagram
    home-reserve
    new-reservation-form
    existing-reservation-form
    openings_monday
    openings_tuesday
    openings_wednesday
    openings_thursday
    openings_friday
    openings_saturday
    openings_sunday
  ].freeze

  enum status: {
    active: "active",
    inactive: "inactive"
  }

  # ################################
  # Validations
  # ################################
  validates :key, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) + statuses.keys.map(&:to_sym) }

  # ################################
  # Scopes
  # ################################
  scope :visible, -> { where(status: :active) }
end
