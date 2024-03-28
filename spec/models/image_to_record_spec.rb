# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImageToRecord do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "associations" do
    it { is_expected.to belong_to(:image) }
    it { is_expected.to belong_to(:record) }
  end
end
