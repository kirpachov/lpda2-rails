# frozen_string_literal: true

module Menu
  class Category < ApplicationRecord

    # ##############################
    # Constants, modules
    # ##############################
    include HasImageAttached
    extend Mobility
    translates :name
    translates :description

    VALID_STATUSES = %w[active].freeze
    SECRET_MIN_LENGTH = 8

    enum status: VALID_STATUSES.map { |s| [s, s] }.to_h

    # ##############################
    # Associations
    # ##############################
    belongs_to :menu_visibility, dependent: :destroy, class_name: "Menu::Visibility"
    alias_attribute :visibility_id, :menu_visibility_id
    alias_attribute :visibility, :menu_visibility

    belongs_to :parent, class_name: "Menu::Category", optional: true
    has_many :children, class_name: "Menu::Category", foreign_key: :parent_id #, dependent: :destroy

    has_many :menu_dishes_in_categories, class_name: 'Menu::DishesInCategory', foreign_key: :menu_category_id

    has_many :menu_dishes, through: :menu_dishes_in_categories, class_name: 'Menu::Dish', dependent: :destroy
    alias_attribute :dishes, :menu_dishes

    # ##############################
    # Validations
    # ##############################
    validates :status, presence: true, inclusion: { in: VALID_STATUSES }
    validates :secret, presence: true, length: { minimum: SECRET_MIN_LENGTH }, uniqueness: { case_sensitive: false }, format: { multiline: true, with: /^[a-zA-Z0-9_\-]+$/ }
    validates :secret_desc, uniqueness: { case_sensitive: false }, allow_nil: true, format: { multiline: true, with: /^[a-zA-Z0-9_\-]+$/ }
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :index, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true, uniqueness: { scope: :parent_id }
    validate :other_cannot_be_nil
    validate :parent_id_cannot_be_self

    # ##############################
    # Hooks
    # ##############################
    before_validation :assign_defaults, on: :create
    before_validation :assign_valid_index, on: :update
    before_destroy :check_if_has_children

    # ##############################
    # Scopes
    # ##############################
    scope :visible, -> { where(status: %w[active]) }

    # ##############################
    # Class methods
    # ##############################
    class << self
      def filter_by_query(query)
        return all unless query.present?

        where(id: ransack(name_cont: query).result.select(:id)
        ).or(where(id: ransack(description_cont: query).result.select(:id)))
      end
    end

    # ##############################
    # Instance methods
    # ##############################
    def assign_defaults
      self.status = 'active' if status.blank?
      assign_valid_index if index.to_i.zero?
      self.secret = GenToken.for!(self.class, :secret) if secret.blank?
      self.other = {} if other.nil?
      self.visibility = Menu::Visibility.new if visibility.nil? && visibility_id.nil?
    end

    def assign_valid_index
      self.index = Category.where(parent_id: parent_id).order(index: :desc).first&.index.to_i + 1
    end

    def remove_parent!
      update!(parent_id: nil)
    end

    def has_children?
      children.count.positive?
    end

    def status=(value)
      super
    rescue ArgumentError
      @attributes.write_cast_value("status", value)
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

    def check_if_has_children
      return unless has_children?

      errors.add(:base, "can't delete category with children")
      throw :abort
    end
  end
end
