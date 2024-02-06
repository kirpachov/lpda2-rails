# frozen_string_literal: true

class CopyImage < ActiveInteraction::Base
  record :old, class: Image
  record :current_user, class: User

  DONT_COPY_ATTRIBUTES = %w[id created_at updated_at].freeze

  def execute
    Log::ModelChange.with_current_user(current_user) do
      new = Image.new
      new.assign_attributes(old.attributes.except(*DONT_COPY_ATTRIBUTES))
      new.validate && new.save!
      new.attached_image.attach(io: old.file, filename: old.filename) if old.attached_image.attached?
      new
    end
  end
end
