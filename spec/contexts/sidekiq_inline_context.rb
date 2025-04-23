# frozen_string_literal: true

SIDEKIQ_INLINE_TESTING = "SIDEKIQ_INLINE_TESTING spec context"
RSpec.shared_context SIDEKIQ_INLINE_TESTING do
  around do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end
end
