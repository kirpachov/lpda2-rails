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

  enum :status, {
    active: :active,
    deleted: :deleted,
    inactive: :inactive
  }

  # ################################
  # Associations
  # ################################
  has_many :table_type_to_preorder_reservation_groups, dependent: :restrict_with_error
  has_many :preorder_reservation_groups, through: :table_type_to_preorder_reservation_groups
  has_one :reservation, dependent: :nullify

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
  # Scopes
  # ################################
  scope :visible, -> { where.not(status: :deleted) }

  # ##############################
  # Class methods
  # ##############################
  class << self
    def filter_by_query(query)
      return all unless query.present?

      where_name(query).or(where_description(query))
    end

    def where_name(query)
      return all unless query.present?

      where(id: ransack(name_cont: query).result.select(:id))
    end

    def where_description(query)
      return all unless query.present?

      where(id: ransack(description_cont: query).result.select(:id))
    end
  end

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

  def soft_delete
    if table_type_to_preorder_reservation_groups.any?
      errors.add(:base, "Pagamenti alla prenotazione associati. Rimuovili prima di eliminare il tipo di tavolo.")
      return false
    end

    update(status: :deleted)
  end
end
