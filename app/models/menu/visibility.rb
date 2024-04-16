# frozen_string_literal: true

module Menu
  class Visibility < ApplicationRecord
    # ##############################
    # Constants, settings, modules, et...
    # ##############################
    include TrackModelChanges

    # ##############################
    # Validations
    # ##############################
    validates :public_visible, inclusion: { in: [true, false] }
    validates :private_visible, inclusion: { in: [true, false] }
    validate :private_from_should_be_before_private_to
    validate :public_from_should_be_before_public_to

    # ##############################
    # Instance methods
    # ##############################
    def private?
      private_visible == true
    end

    def public?
      public_visible == true
    end

    def public!
      update!(public_visible: true)
    end

    def private!
      update!(private_visible: true)
    end

    private

    def public_from_should_be_before_public_to
      return if public_from.nil? || public_to.nil?
      return if public_from.to_i < public_to.to_i

      errors.add(:public_from,
                 I18n.t("activerecord.errors.messages.public_from_should_be_before_public_to", public_from:,
                                                                                               public_to:))
      errors.add(:public_to,
                 I18n.t("activerecord.errors.messages.public_to_should_be_after_public_from", public_from:, public_to:))
    end

    def private_from_should_be_before_private_to
      return if private_from.nil? || private_to.nil?
      return if private_from.to_i < private_to.to_i

      errors.add(:private_from,
                 I18n.t("activerecord.errors.messages.private_from_should_be_before_private_to", private_from:,
                                                                                                 private_to:))
      errors.add(:private_to,
                 I18n.t("activerecord.errors.messages.private_to_should_be_after_private_from", private_from:,
                                                                                                private_to:))
    end
  end
end
