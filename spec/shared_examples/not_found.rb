# frozen_string_literal: true

NOT_FOUND = 'NOT_FOUND'
RSpec.shared_examples NOT_FOUND do
  it { should have_http_status(:not_found) }
  it { expect(parsed_response_body).to include(message: String) }
  it { expect(parsed_response_body).to include(details: Hash) }
  it { expect(parsed_response_body[:message].downcase).to include('unable to find') }
end
