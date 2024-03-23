# frozen_string_literal: true

class ImageToRecord < ApplicationRecord
  # ##############################
  # Associations
  # ##############################
  belongs_to :image, class_name: 'Image', optional: false
  belongs_to :record, polymorphic: true, optional: false

  # ##############################
  # Validations
  # ##############################
  validate :image_must_have_attached_image

  validates :image, uniqueness: { scope: :record }
  validates :position, uniqueness: { scope: :record }

  # ##############################
  # Hooks
  # ##############################
  after_initialize :assign_next_position, if: -> { new_record? }

  # ##############################
  # Class methods
  # ##############################
  class << self
    def move(record, from_index, to_index)
      to_index = where(record:).count - 1 if to_index >= where(record:).count

      transaction do
        lock

        where(record:).update_all('position = position + 100000')

        items = where(record:).order(:position).to_ary

        items.filter { |t| t.id != items[from_index].id }.each_with_index do |image_to_record, index|
          image_to_record.position = to_index > index ? index : index + 1
        end

        items[from_index].position = to_index

        import items, on_duplicate_key_update: { columns: %i[position] }, validate: false, touch: true
      end

      true
    end
  end

  # ##############################
  # Instance methods
  # ##############################
  def assign_next_position
    self.position = self.class.where(record:).order(position: :desc).first&.position.to_i + 1
  end

  private

  def image_must_have_attached_image
    return if image.nil? || image.attached_image.attached?

    errors.add(:image, 'must have attached image')
  end
end
