# frozen_string_literal: true

# Running AsyncAction in background.
class SaveModelChangeJob
  # Warning! Not extending "ApplicationJob"
  include Sidekiq::Worker
   sidekiq_options retry: 0, queue: 'default'

  def perform(data)
    Log::ModelChange.create!(data)
  end
end
