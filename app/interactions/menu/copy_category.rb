# frozen_string_literal: true

module Menu
  class CopyCategory < ActiveInteraction::Base
    DEFAULT_COPY_IMAGES = "full"
    DEFAULT_COPY_DISHES = "full"
    DEFAULT_COPY_CHILDREN = "full"

    # ACCEPTING:
    # old: Category, required
    # current_user: User, required
    #
    # parent_id: Integer | NullClass
    # copy_images: String, inclusion: [full, link, none]
    # copy_dishes: String, inclusion: [full, link, none]
    # copy_children: String, inclusion: [full, none]
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    DONT_COPY_ATTRIBUTES = %w[id created_at updated_at secret index secret_desc menu_visibility_id].freeze

    attr_reader :new

    def execute
      ::Log::ModelChange.with_current_user(current_user) do

        @new = Category.new

        Category.transaction do
          raise ActiveRecord::Rollback unless do_copy_category &&
            do_copy_images &&
            do_copy_dishes &&
            do_copy_children
        end

        @new
      end
    end

    private

    def old
      params[:old]
    end

    def current_user
      params[:current_user]
    end

    def copy_images
      params.fetch(:copy_images, DEFAULT_COPY_IMAGES)
    end

    def validate_copy_images
      return if copy_images.in?(%w[full link none])

      errors.add(:copy_images, :inclusion, value: copy_images)
    end

    def copy_dishes
      params.fetch(:copy_dishes, DEFAULT_COPY_DISHES)
    end

    def validate_copy_dishes
      return if copy_dishes.in?(%w[full link none])

      errors.add(:copy_dishes, :inclusion, value: copy_dishes)
    end

    def copy_children
      params.fetch(:copy_children, DEFAULT_COPY_CHILDREN)
    end

    def validate_copy_children
      return if copy_children.in?(%w[full none])

      errors.add(:copy_children, :inclusion, value: copy_children)
    end

    def do_copy_category
      I18n.available_locales.each do |locale|
        Mobility.with_locale(locale) do
          @new.name = old.name
          @new.description = old.description
        end
      end

      @new.assign_attributes(old.attributes.except(*DONT_COPY_ATTRIBUTES))
      @new.parent_id = params[:parent_id].blank? ? nil : params[:parent_id] if params.key?(:parent_id)
      @new.other = (old.other || {}).merge(copied_from: old.id)

      return true if @new.valid? && @new.save

      errors.merge!(@new.errors)
      false
    end

    def do_copy_images
      return true if old.images.empty? || copy_images.to_s == 'none'

      old.images.filter { |img| img.attached_image.attached? }.each do |old_image|
        if copy_images == 'full'
          @new.images << old_image.copy!(current_user:)
        elsif copy_images == 'link'
          @new.images << old_image
        end
      end

      true

    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy image: #{e.message}", details: e)
      false
    end

    def do_copy_dishes
      return true if old.dishes.empty? || copy_dishes.to_s == 'none'

      old.dishes.each do |old_dish|
        if copy_dishes == 'full'
          @new.dishes << old_dish.copy!(current_user:)
        elsif copy_dishes == 'link'
          @new.dishes << old_dish
        end
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy dish: #{e.message}", details: e)
      false
    end

    def do_copy_children
      return true if old.children.empty? || copy_children.to_s == 'none'

      old.children.each do |old_child|
        @new.children << old_child.copy!(current_user:)
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy child category: #{e.message}", details: e)
    end
  end
end
