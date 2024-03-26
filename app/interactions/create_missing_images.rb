# frozen_string_literal: true

# Will read
# app/assets/img/autocreate/*
# and create Image records from the images found there.
class CreateMissingImages < ActiveInteraction::Base
  def execute
    # Read all files from the directory
    Dir.glob('app/assets/img/autocreate/**/**').map do |filepath|
      next if File.directory?(filepath)
      next unless File.extname(filepath).in?(%w[.png .jpg .jpeg .gif .svg .jpeg])

      key = filepath.split('/autocreate/').last.split('.')[0..-2].join('.').gsub('/', '_').gsub(/[^a-z0-9_-]/i,
                                                                                                '').downcase

      next if Image.where(key:).count.positive?

      Image.create!(filename: File.basename(filepath), key:).tap do |image|
        image.attached_image.attach(io: File.open(filepath), filename: File.basename(filepath))
      end
    end
  end
end
