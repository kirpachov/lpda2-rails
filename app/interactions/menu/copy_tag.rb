# frozen_string_literal: true

module Menu
  class CopyTag < ActiveInteraction::Base
    record :old, class: Tag
    record :current_user, class: User

    string :copy_image, default: 'full'

    validates :copy_image, inclusion: { in: %w[full link none] }

    DONT_COPY_ATTRIBUTES = %w[id created_at updated_at].freeze

    def execute
      ::Log::ModelChange.with_current_user(current_user) do

        @new = Tag.new

        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            @new.name = old.name
            @new.description = old.description
          end
        end

        @new.assign_attributes(old.attributes.except(*DONT_COPY_ATTRIBUTES))

        @new.validate && @new.save!

        if copy_image.in?(%w[full link]) && old.image && old.image.attached_image.attached?
          @new.image = copy_image == 'full' ? old.image.copy!(current_user:) : old.image
        end

        @new
      end
    end
  end
end
