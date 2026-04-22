# frozen_string_literal: true

TESTS_OPTIMIZATIONS_CONTEXT = "Tests optimizations context"
RSpec.shared_context TESTS_OPTIMIZATIONS_CONTEXT do
  def disable_model_change_logs
    allow(SaveModelChangeJob).to receive(:perform_async).and_return(true)
  end

  def enable_model_change_logs
    allow(SaveModelChangeJob).to receive(:perform_async).and_call_original
  end

  before do
    disable_model_change_logs
  end
end
