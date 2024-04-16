# frozen_string_literal: true

TESTS_OPTIMIZATIONS_CONTEXT = "Tests optimizations context"
RSpec.shared_context TESTS_OPTIMIZATIONS_CONTEXT do
  before do
    allow(SaveModelChangeJob).to receive(:perform_async).and_return(true)
  end
end
