# frozen_string_literal: true

# Saving model changes in a background job
class SaveModelChangeJob
  include Sidekiq::Worker
   sidekiq_options retry: 0, queue: 'default'

  def perform(data)
    Log::ModelChange.create!(data)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Error saving model change: #{e.message} [data: #{data}]")
  end
end
