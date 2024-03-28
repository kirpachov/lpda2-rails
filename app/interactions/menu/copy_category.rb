# frozen_string_literal: true

module Menu
  class CopyCategory < ActiveInteraction::Base
    DEFAULT_COPY_IMAGES = "full"
    DEFAULT_COPY_DISHES = "full"
    DEFAULT_COPY_CHILDREN = "full"

    PERMITTED_KEYS = %i[old current_user parent_id copy_images copy_dishes copy_children].freeze

    # ACCEPTING:
    # old: Category, required
    # current_user: User, required
    #
    # parent_id: Integer | NullClass
    # copy_images: String, inclusion: [full, link, none]
    # copy_dishes: String, inclusion: [full, link, none]
    # copy_children: String, inclusion: [full, none]
    interface :params, methods: %i[[] merge! fetch each has_key?], default: {}

    validate :validate_params_keys
    validate :validate_copy_images
    validate :validate_copy_dishes
    validate :validate_copy_children
    validate :validate_parent_id
    validate :validate_current_user
    validate :validate_old

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
      return DEFAULT_COPY_IMAGES if params[:copy_images].blank?

      params[:copy_images]
    end

    def validate_copy_images
      return if copy_images.in?(%w[full link none])

      errors.add(:copy_images, :inclusion, value: copy_images)
    end

    def copy_dishes
      return DEFAULT_COPY_DISHES if params[:copy_dishes].blank?

      params[:copy_dishes]
    end

    def validate_copy_dishes
      return if copy_dishes.in?(%w[full link none])

      errors.add(:copy_dishes, :inclusion, value: copy_dishes)
    end

    def copy_children
      return DEFAULT_COPY_CHILDREN if params[:copy_children].blank?

      params[:copy_children]
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
      @new.parent_id = (params[:parent_id].presence) if params.key?(:parent_id)
      @new.other = (old.other || {}).merge(copied_from: old.id)

      return true if @new.valid? && @new.save

      errors.merge!(@new.errors)
      false
    end

    def do_copy_images
      return true if old.images.empty? || copy_images.to_s == "none"

      old.images.filter { |img| img.attached_image.attached? }.each do |old_image|
        if copy_images == "full"
          @new.images << old_image.copy!(current_user:)
        elsif copy_images == "link"
          @new.images << old_image
        end
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy image: #{e.message}", details: e)
      false
    end

    def do_copy_dishes
      return true if old.dishes.empty? || copy_dishes.to_s == "none"

      old.dishes.each do |old_dish|
        if copy_dishes == "full"
          @new.dishes << old_dish.copy!(current_user:)
        elsif copy_dishes == "link"
          @new.dishes << old_dish
        end
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy dish: #{e.message}", details: e)
      false
    end

    def do_copy_children
      return true if old.children.empty? || copy_children.to_s == "none"

      old.children.each do |old_child|
        @new.children << old_child.copy!(current_user:)
      end

      true
    rescue ActiveRecord::RecordInvalid, ActiveInteraction::InvalidInteractionError => e
      errors.add(:base, "Cannot copy child category: #{e.message}", details: e)
    end

    ##################
    # Validations
    ##################
    def validate_params_keys
      actual_keys = params.keys.map(&:to_sym)
      return if (unknown_keys = (actual_keys - PERMITTED_KEYS)).empty?

      unknown_keys.each do |key, value|
        errors.add(:params, "Unknown key: #{key} with value: #{value}")
      end
    end

    def validate_parent_id
      return if params[:parent_id].blank? || params[:parent_id].is_a?(Integer)
      return if params[:parent_id].is_a?(String) && params[:parent_id].to_i.to_s == params[:parent_id]

      errors.add(:parent_id, "must be an Integer or nil. got: #{params[:parent_id].class}")
    end

    def validate_current_user
      return if current_user.is_a?(User)

      errors.add(:current_user, "must be a User. got: #{current_user.class}")
    end

    def validate_old
      return if old.is_a?(::Menu::Category)

      errors.add(:old, "must be a Category. got: #{old.class}")
    end
  end
end
