# frozen_string_literal: true

# text to shown in the public pages to warn people about things.
class PublicMessage < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  extend Mobility
  translates :text

  enum status: {
    active: "active",
    inactive: "inactive"
  }

  # ################################
  # Validations
  # ################################
  validates :key, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) + statuses.keys.map(&:to_sym) }
end
