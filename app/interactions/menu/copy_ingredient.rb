# frozen_string_literal: true

module Menu
  class CopyIngredient < ActiveInteraction::Base
    record :old, class: Ingredient
    record :current_user, class: User

    string :copy_image, default: "full"

    validates :copy_image, inclusion: { in: %w[full link none] }

    DONT_COPY_ATTRIBUTES = %w[id created_at updated_at].freeze

    def execute
      ::Log::ModelChange.with_current_user(current_user) do
        @new = Ingredient.new

        Ingredient.transaction do
          raise ActiveRecord::Rollback unless do_copy_ingredient &&
                                              do_copy_image
        end

        @new
      end
    end

    def do_copy_ingredient
      I18n.available_locales.each do |locale|
        Mobility.with_locale(locale) do
          @new.name = old.name
          @new.description = old.description
        end
      end

      @new.assign_attributes(old.attributes.except(*DONT_COPY_ATTRIBUTES))

      return true if @new.valid? && @new.save

      errors.merge!(@new.errors)
      false
    end

    def do_copy_image
      return true unless copy_image.in?(%w[full link]) && old.image.present? && old.image.attached_image.attached?

      if copy_image == "full"
        @new.image = old.image.copy!(current_user:)
      elsif copy_image == "link"
        @new.image = old.image
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Could not copy image: #{e.message}")
      false
    end
  end
end
