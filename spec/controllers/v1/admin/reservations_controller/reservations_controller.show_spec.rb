# frozen_string_literal: true

require "rails_helper"

RSpec.shared_context "V1::Admin::ReservationsController#show item structure" do |options = {}|
  it "has valid structure" do
    expect(subject).to be_a(Hash)
    expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, adults: Integer,
                               children: Integer, status: String)
  end

  # true => check presence
  # false => check absence
  # String => check exact value
  %i[phone email notes].each do |field|
    if options[field] == true
      it "has #{field.inspect}" do
        expect(subject).to include(field.to_sym => String)
      end
    elsif options[field] == false
      it "does not have #{field}" do
        expect(subject[field].to_s).to be_blank
      end
    elsif options[field].is_a?(String)
      it "has #{field.inspect} = #{options[field].inspect}" do
        expect(subject).to include(field.to_sym => options[field])
      end
    end
  end
end

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "GET #show" do
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/admin/reservations/2").to(action: :show, format: :json, id: 2) }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(2) }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "basic" do
        subject { response }

        before { req(reservation.id) }

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body[:item].transform_keys(&:to_sym) }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:id, :updated_at) }

          it_behaves_like "V1::Admin::ReservationsController#show item structure"
        end
      end

      context "when passing a invalid id" do
        subject { response }

        before { req(id: 999_999) }

        it_behaves_like NOT_FOUND
      end

      context "checking pixel events" do
        before do
          CreateMissingImages.run!
          reservation.deliver_confirmation_email
          reservation.image_pixels.first.events.create!(event_time: Time.now)
          req(reservation.id)
        end

        it do
          expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels)).to be_a(Array)
          expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).length).to eq 1
          json = parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).first
          expect(json).to be_a(Hash)
          expect(json).to include(events: Array)
          expect(json[:events]).to all(be_a(Hash))
          expect(json[:events]).to all(include(id: Integer, event_time: String))
          expect(json[:events].length).to eq 1
        end
      end
    end
  end
end
