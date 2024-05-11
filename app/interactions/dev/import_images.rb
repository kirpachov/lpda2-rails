# frozen_string_literal: true

module Dev
  # Import images from the old application.
  # Images will be located in the migration/images folder.
  # the name of the image will be the member_id of the Image.
  class ImportImages < ActiveInteraction::Base
    SUPPORTED_FORMATS = %w[jpg jpeg png svg].freeze

    boolean :verbose, default: false

    def execute
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::ERROR) do
        all.each_with_index do |file, index|
          Rails.logger.error "Importing image #{index + 1}/#{all.size}: #{file}" if ((index + 1) % 100).zero?

          Image.create!(filename: file[:filename], member_id: file[:member_id]).tap do |image|
            image.attached_image.attach(io: File.open(file[:path]), filename: file[:filename])
          end
        end
      end
    end

    def existing
      @existing ||= Image.pluck(:member_id)
    end

    def all
      @all ||= Dir[Rails.root.join("migration/images/*")].map do |file|
                 { path: file, filename: File.basename(file),
                   member_id: File.basename(file).split(".")[0..-2].join(".") }
               end.filter do |file_data|
        File.file?(file_data[:path]) &&
          !file_data[:member_id].in?(existing) &&
          File.basename(file_data[:filename]).split(".").last.in?(SUPPORTED_FORMATS)
      end
    end
  end
end
