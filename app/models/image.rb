# frozen_string_literal: true

class Image < ApplicationRecord
  # ################################
  # Constants, settings, modules, et...
  # ################################
  include TrackModelChanges
  # include ImageBlur

  VALID_STATUSES = %w[active deleted].freeze
  VALID_TAGS = %w[blur].freeze

  extend Mobility
  translates :title
  translates :description

  enum status: VALID_STATUSES.map { |s| [s, s] }.to_h
  enum tag: VALID_TAGS.map { |t| [t, t] }.to_h

  # ################################
  # Associations
  # ################################
  has_many :image_to_records, dependent: :destroy
  has_one_attached :attached_image, dependent: :destroy
  belongs_to :original, class_name: 'Image', optional: true
  has_many :children, class_name: 'Image', foreign_key: :original_id, dependent: :destroy

  # ################################
  # Validations
  # ################################
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }
  validates :filename, presence: true
  validates :tag, presence: true, if: -> { original.present? }
  validates :tag, inclusion: { in: VALID_TAGS }, allow_nil: true

  # ################################
  # Callbacks
  # ################################
  before_validation :assign_defaults, on: :create

  # ################################
  # Scopes
  # ################################
  scope :original, -> { where(original_id: nil) }
  scope :not_original, -> { where.not(original_id: nil) }
  scope :visible, -> { where(status: 'active') }
  scope :with_attached_image, -> { joins(:attached_image_attachment).where.not(attached_image_attachment: { id: nil }) }

  # ################################
  # Class methods
  # ################################
  class << self
    def create_from_url(data)
      data = data.with_indifferent_access
      raise 'url is blank' if data['url'].blank?

      data['filename'] = File.basename(data['url']) if data['filename'].blank? && File.basename(data['url']).present?

      record = create!(data.except('url', :url))
      record.attached_image.attach(io: Down.open(data['url']), filename: record.filename)
      record
    end

    # Create by controller params
    # Image.create_from_param(params[:image])
    def create_from_param!(data)
      unless data.is_a?(ActionDispatch::Http::UploadedFile)
        raise "ActionDispatch::Http::UploadedFile expected, got #{data.class}"
      end

      record = create!(filename: data.original_filename)
      record.attached_image.attach(io: data, filename: data.original_filename)
      # record.attached_image.attach(data)
      record
    end
  end

  # ################################
  # Instance methods
  # ################################
  VALID_TAGS.each do |tag|
    define_method "#{tag}_image" do
      @image_variants ||= {}

      return @image_variants[tag] if @image_variants[tag].present?

      # GenerateImageVariants.run!(image: self)
      @image_variants[tag] ||= children.visible.where(tag:).first
    end
  end

  # @param [Hash] options
  # @option options [User] :current_user
  def copy!(options = {})
    CopyImage.run!(options.merge(old: self))
  end

  # @param [Hash] options
  # @option options [User] :current_user
  def copy(options = {})
    CopyImage.run(options.merge(old: self))
  end

  def find_variant(tag)
    children.visible.find_by(tag:)
  end

  def find_variant!(tag)
    generate_image_variants! if find_variant(tag).nil? && VALID_TAGS.include?(tag.to_s)

    children.visible.find_by!(tag:)
  end

  def full_json
    as_json.merge(url:)
  end

  def generate_image_variants!(options = {})
    GenerateImageVariants.run!(options.merge(image: self))
  end

  def download
    attached_image&.download
  end

  def content_type
    attached_image&.content_type
  end

  def has_original?
    original.present? || original_id.present?
  end

  def assign_defaults
    self.status ||= 'active'
  end

  def url
    return nil unless attached_image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(attached_image, host: Config.base_url)
  end

  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('status', value)
  end

  def tag=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('tag', value)
  end

  def is_original?
    original_id.nil? && original.nil?
  end

  def file_contents
    attached_image.attached? ? attached_image.download : nil
  end

  def file
    Tempfile.new([filename, ".#{filename.split('.').last}"]).tap do |file|
      file.binmode
      file.write(file_contents)
      file.rewind
    end
  end

  def download_by_key_url
    return nil if key.blank?

    @download_by_key_url ||= Rails.application.routes.url_helpers.download_by_key_images_url(key:)
  end
end
