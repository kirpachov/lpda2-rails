# frozen_string_literal: true

module Log
  # This model is used to track changes of other models.
  class ModelChange < ApplicationRecord # rubocop:disable Metrics/ClassLength
    # ############################
    # Concerns
    # ############################
    include HasOtherJson

    # ############################
    # Associations
    # ############################
    belongs_to :user, optional: true
    belongs_to :record, polymorphic: true, optional: false

    # ############################
    # Validations
    # ############################
    validates_presence_of :change_type, :version

    validate :changed_fields_must_be_array_validator
    validate :changed_fields_must_refer_to_record_attributes, if: -> { %w[create update].include?(change_type) }
    validate :record_changes_cannot_be_empty, if: -> { %w[create update].include?(change_type) }
    validates :version, numericality: { only_integer: true, greater_than: 0 }
    validates :change_type, inclusion: { in: %w[create update delete] }
    validates_uniqueness_of :version, scope: %i[record_id record_type]

    # ############################
    # Callbacks
    # ############################
    before_validation :assign_defaults

    # ############################
    # Scopes
    # ############################
    scope :for_record, ->(record) { where(record:) }
    scope :for_user, ->(user) { where(user:) }
    scope :for, ->(args) { where(record: args.delete(:record), user: args.delete(:user)) }
    scope :with_user, -> { includes(:user) }
    scope :has_user, -> { where.not(user_id: nil) }
    scope :has_no_user, -> { where(user_id: nil) }
    scope :hasnt_user, -> { has_no_user }
    scope :with_record, -> { includes(:record) }
    scope :created, -> { where(change_type: 'create') }
    scope :not_created, -> { where.not(change_type: 'create') }
    scope :updated, -> { where(change_type: 'update') }
    scope :not_updated, -> { where.not(change_type: 'update') }
    scope :deleted, -> { where(change_type: 'delete') }
    scope :not_deleted, -> { where.not(change_type: 'delete') }

    # ############################
    # Class Methods
    # ############################
    class << self
      def created(record, args = {})
        create(parse_params(record, args, :create))
      end

      def created!(record, args = {})
        create!(parse_params(record, args, :create))
      end

      def updated(record, args = {})
        create(parse_params(record, args, :update))
      end

      def updated!(record, args = {})
        create!(parse_params(record, args, :update))
      end

      def deleted(record, args = {})
        create(parse_params(record, args, :delete))
      end

      def deleted!(record, args = {})
        create!(parse_params(record, args, :delete))
      end

      def parse_params(record, args, change_type)
        (args || {}).slice(*column_names).merge(
          record:,
          change_type:,
          record_changes: args.slice(*record.class.column_names),
          user: args[:user] || $current_user
        )
      end

      def with_current_user(user)
        old_current_user_id = $current_user_id
        $current_user_id = user.id
        yield
      ensure
        $current_user_id = old_current_user_id
      end
    end

    # ############################
    # Instance Methods
    # ############################

    def assign_defaults
      set_changed_fields
      self.record_changes ||= {}
      self.changed_fields ||= []
      self.other ||= {}
      assign_version if new_record?
    end

    def assign_version(items = self.class.for_record(record).order(version: :desc))
      self.version = items.first&.version.to_i + 1
    end

    def created?
      change_type == 'create'
    end

    def updated?
      change_type == 'update'
    end

    def deleted?
      change_type == 'delete'
    end

    def set_changed_fields
      self.changed_fields = (record_changes || {}).keys
    end

    # ############################
    # Private methods
    # ############################

    private

    def record_changes_cannot_be_empty
      return if record_changes.is_a?(Hash) && !record_changes.empty?

      errors.add(:record_changes, 'cannot be empty')
    end

    def changed_fields_must_refer_to_record_attributes
      return if changed_fields.nil? || changed_fields.empty? || record.nil?

      changed_fields.each do |field|
        errors.add(:changed_fields, 'must refer to record attributes') unless record.respond_to?(field)
      end
    end

    def changed_fields_must_be_array_validator
      return if changed_fields.is_a?(Array)

      errors.add(:changed_fields, 'must be an array')
    end

    def record_changes_must_be_hash_validator
      return if record_changes.is_a?(Hash)

      errors.add(:record_changes, 'must be a hash')
    end
  end
end
