# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  context "POST #deliver_confirmation_email" do
    let(:params) { { id: reservation.id } }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/2/deliver_confirmation_email").to(
        action: :deliver_confirmation_email, id: "2", format: :json
      )
    }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/55/deliver_confirmation_email").to(
        action: :deliver_confirmation_email, id: "55", format: :json
      )
    }

    it { expect(instance).to respond_to(:deliver_confirmation_email) }

    def req(_params = params)
      post :deliver_confirmation_email, params: _params
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to deliver a non-existing reservation" do
        subject { response }

        before { req(id: 999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when reservation is valid" do
        before do
          CreateMissingImages.run!
        end

        it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }

        it "is successful" do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        context "when reservation has name" do
          before do
            allow_any_instance_of(Hash).to receive(:dig!).and_call_original
            CreateMissingImages.run!
          end

          let(:reservation) { create(:reservation, fullname: "Anne Marie") }
          let(:to) { ActionMailer::Base.deliveries.last.header[:to].unparsed_value }

          it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }
          it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
          it { expect { req }.to change { Log::DeliveredEmail.where(record: reservation).count }.by(1) }
          it { expect { req }.to change { Log::ImagePixel.count }.by(1) }

          it "is successful" do
            req
            expect(to).to include(reservation.email)
            expect(to).to include(reservation.fullname)
            expect(parsed_response_body).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end

          it "last delivered email should have the correct reservation" do
            Log::DeliveredEmail.delete_all
            Log::ImagePixel.delete_all
            req
            expect(Log::DeliveredEmail.last.subject).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.text).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.html).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.raw).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.html).to include(Log::ImagePixel.last.url)
            expect(Log::DeliveredEmail.last.record).to eq reservation
          end
        end

        context "when reservation has no email" do
          let(:reservation) { create(:reservation, email: nil) }
          let(:to) { ActionMailer::Base.deliveries.last.header[:to].unparsed_value }

          it { expect { req }.not_to(change { ActionMailer::Base.deliveries.count }) }

          it "is successful" do
            req
            expect(parsed_response_body).to include(message: String, details: Hash)
            expect(response).to have_http_status(:bad_request)
          end
        end

        context "after request" do
          before { req }

          it "returns delivery details" do
            expect(parsed_response_body).to include(item: Hash)
            expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
            expect(response).to have_http_status(:ok)
          end

          it do
            expect(parsed_response_body.dig(:item, :delivered_emails)).to be_a(Array)
            expect(parsed_response_body.dig(:item, :delivered_emails).length).to eq 1
            expect(parsed_response_body.dig(:item,
                                            :delivered_emails).first).to include(id: Integer, created_at: String,
                                                                                 image_pixels: Array)
            expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels)).to be_a(Array)
            expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).length).to eq 1
          end
        end
      end
    end
  end
end
