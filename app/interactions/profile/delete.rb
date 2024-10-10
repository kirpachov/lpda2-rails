# frozen_string_literal: true

module Profile
  # Implements the logic for user profile deletion and data anonymization.
  class Delete < ActiveInteraction::Base
    object :user, class: User

    def execute
      User.transaction do
        delete_user!
        invalidate_refresh_tokens!
      end
    end

    private

    def delete_user!
      anonymized_data = {
        status: :deleted,
        email: "deleted+#{user.id}@localhost",
        fullname: "[DELETED]"
      }

      errors.merge!(user.errors) unless user.update(anonymized_data)

      raise ActiveRecord::Rollback unless errors.empty?
    end

    def invalidate_refresh_tokens!
      user.refresh_tokens.not_expired.delete_all
    end
  end
end
