# frozen_string_literal: true

module Nexi
  # Traking HTTP requests to nexi API.
  class HttpRequest < ApplicationRecord
    # ###################################
    # Validations
    # ###################################
    validates_presence_of :request_body,
                          :response_body,
                          :url,
                          :http_code,
                          :http_method,
                          :started_at,
                          :ended_at

    # ###################################
    # Attachments
    # ###################################
    has_one_attached :cached_file

    # ###################################
    # Instance methods
    # ###################################

    def time
      (ended_at - started_at).to_f
    end

    # Returns instance of ActiveStorage::Attachment
    def attachment(reload: false)
      cached_file.purge if reload

      cached_file&.attachment || (generate_and_attach_file && cached_file&.attachment)
    end

    # Returns instance of File.
    def file
      attachment&.blob&.open do |file|
        Tempfile.new([filename, '.json']).tap do |temp_file|
          temp_file.write(file.read.force_encoding('UTF-8'))
          temp_file.rewind
        end
      end
    end

    def generate_and_attach_file
      cached_file.attach(io: generate_file, filename:)
    end

    def generate_file
      Tempfile.new([filename, '.json']).tap do |file|
        file.write(to_json)
        file.rewind
      end
    end

    # ###################################
    # Private methods
    # ###################################
    private

    def filename
      "nexi_http_request_#{id}"
    end
  end
end
