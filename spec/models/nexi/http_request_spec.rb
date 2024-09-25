# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Nexi::HttpRequest, type: :model do
  context 'validations' do
    context 'request_body' do
      it { is_expected.to validate_presence_of(:request_body) }
    end

    context 'response_body' do
      it { is_expected.to validate_presence_of(:response_body) }
    end

    context 'url' do
      it { is_expected.to validate_presence_of(:url) }
    end

    context 'http_code' do
      it { is_expected.to validate_presence_of(:http_code) }
    end

    context 'http_method' do
      it { is_expected.to validate_presence_of(:http_method) }
    end

    context 'started_at' do
      it { is_expected.to validate_presence_of(:started_at) }
    end

    context 'ended_at' do
      it { is_expected.to validate_presence_of(:ended_at) }
    end
  end
end
