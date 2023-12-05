# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageToRecord do
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context 'associations' do
    it { should belong_to(:image) }
    it { should belong_to(:record) }
  end
end
