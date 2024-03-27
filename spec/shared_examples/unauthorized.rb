# frozen_string_literal: true

UNAUTHORIZED = 'unauthorized'
RSpec.shared_examples UNAUTHORIZED do
  subject { response }

  it { is_expected.to have_http_status(:unauthorized) }

  context 'response' do
    subject { parsed_response_body }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to include(message: String, details: Hash) }
    it { expect(subject[:message]).to eq 'Unauthorized' }
  end
end
