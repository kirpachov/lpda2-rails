# frozen_string_literal: true

require "csv"

module Dev
  # Import images from the old application.
  # In development, test this lib in console:
  # Dev::ImportImages.run!
  class ImportImages < ActiveInteraction::Base
    SUPPORTED_FORMATS = %w[jpg jpeg png svg].freeze

    string :csv_location, default: Rails.root.join("migration", "records", "media.csv").to_s
    string :images_location, default: Rails.root.join("migration", "images").to_s
    boolean :verbose, default: false

    def execute
      row_index = 0
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::ERROR) do
        CSV.foreach(csv_location, headers: true, col_sep: ";", liberal_parsing: true) do |row|
          image = Image.find_or_initialize_by(member_id: row["id"])
          file_path = Dir["#{images_location}/#{row["id"]}.#{row["extension"]}"]

          if file_path.any? && File.file?(file_path[0])
            image.filename = "#{row["id"]}.#{row["extension"]}"
            image.attached_image.attach(io: File.open(file_path[0]), filename: "#{row["id"]}.#{row["extension"]}")
            image.save!
          else
            Rails.logger.error "Image file not found: #{file_path[0]} for row #{row_index}"
          end

          row_index += 1
        end
      end
    end
  end
end
