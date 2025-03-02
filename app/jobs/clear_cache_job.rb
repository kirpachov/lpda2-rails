# frozen_string_literal: true

# Clear rails cache job; cache invalidation
class ClearCacheJob
  include Sidekiq::Worker
  sidekiq_options retry: 0, queue: "default"

  def perform(*_)
    Rails.cache.clear
  end
end
