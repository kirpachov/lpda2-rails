# frozen_string_literal: true

UNAUTHORIZED = 'unauthorized'
RSpec.shared_examples UNAUTHORIZED do
  subject { response }
  it { should have_http_status(:unauthorized) }
  context 'response' do
    subject { parsed_response_body }
    it { should be_a(Hash) }
    it { should include(message: String, details: Hash) }
    it { expect(subject[:message]).to eq 'Unauthorized' }
  end
end