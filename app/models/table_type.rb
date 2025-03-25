# frozen_string_literal: true

# A type of table that can be reserved.
# Admins can define when a table type is available for reservation, and the price for each person on the table.
class TableType < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  include HasImagesAttached
  extend Mobility
  translates :name
  translates :description

  enum status: {
    active: :active,

    inactive: :inactive,
  }

  # ################################
  # Associations
  # ################################
  has_many :table_type_to_preorder_reservation_groups, dependent: :restrict_with_error
  has_many :preorder_reservation_groups, through: :table_type_to_preorder_reservation_groups

  # ################################
  # Validators
  # ################################
  validates :default_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :default_people_per_turn, numericality: { greater_than: 0 }, allow_nil: false

  # ################################
  # Defaults
  # ################################
  attribute :status, :string, default: "active"

  # ################################
  # Instance methods
  # ################################
  # {
  #   name: String,
  #   description: String,
  #   images: [
  #     {
  #       id: Integer,
  #       filename: String,
  #       status: String,
  #       ...
  #       url: String
  #     }
  #   ]
  # }
  def public_json
    {
      name:,
      description:,
      images: images.map(&:public_json)
    }
  end
end
