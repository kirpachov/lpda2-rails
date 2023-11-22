# frozen_string_literal: true

module Menu
  class Category < ApplicationRecord

    # ##############################
    # Constants, modules
    # ##############################
    VALID_STATUSES = %w[active].freeze
    SECRET_MIN_LENGTH = 8

    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_visibility, dependent: :destroy, class_name: "Menu::Visibility"
    belongs_to :parent, class_name: "Menu::Category", optional: true
    alias visibility menu_visibility

    # ##############################
    # Validations
    # ##############################
    validates :status, presence: true, inclusion: { in: VALID_STATUSES }
    validates :secret, presence: true, length: { minimum: SECRET_MIN_LENGTH }, uniqueness: { case_sensitive: false }, format: { multiline: true, with: /^[a-zA-Z0-9_\-]+$/ }
    validates :secret_desc, uniqueness: { case_sensitive: false }, allow_nil: true, format: { multiline: true, with: /^[a-zA-Z0-9_\-]+$/ }
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validate :other_cannot_be_nil
    validate :parent_id_cannot_be_self # TODO test this vaidation

    # ##############################
    # Hooks
    # ##############################
    before_validation :assign_defaults, on: :create

    # ##############################
    # Instance methods
    # ##############################
    def assign_defaults
      self.status = 'active' if status.blank?
      self.index = Category.where(parent_id: parent_id).count if index.nil?
      self.secret = GenToken.for!(self.class, :secret) if secret.blank?
      self.other = {} if other.nil?
    end

    private

    def other_cannot_be_nil
      return unless other.nil?

      errors.add(:other, "can't be nil")
    end

    def parent_id_cannot_be_self
      return if id.nil? || parent_id.nil?
      return unless parent_id == id

      errors.add(:parent_id, "can't be self")
    end
  end
end
