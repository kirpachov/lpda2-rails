# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::ReservationsController, type: :controller do
  let(:instance) { described_class.new }

  include_context CONTROLLER_UTILS_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "GET #show" do
    let(:params) { { secret: reservation.secret } }
    let!(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:show) }

    it {
      expect(subject).to route(:get, "/v1/reservations/supersecret").to(format: :json, action: :show, controller: "v1/reservations",
                                                                        secret: "supersecret")
    }

    def req(data = params)
      get :show, params: data
    end

    %w[cancelled deleted].each do |invalid_status|
      context "when reservation is in status #{invalid_status.inspect}" do
        let(:reservation) { create(:reservation, status: :active, datetime: 1.week.from_now) }

        before do
          reservation.update!(status: invalid_status)
          req
        end

        it { expect(response).to have_http_status(:not_found) }
        it { expect(json).not_to include(:item) }
        it { expect(json).to include(message: String) }
      end
    end

    context "basic" do
      context "should return a reservation" do
        it do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
        end

        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        context "checking data structure" do
          subject { parsed_response_body[:item] }

          before { req }

          it {
            expect(subject).to include(
              "id" => reservation.id,
              "fullname" => reservation.fullname,
              "datetime" => reservation.datetime,
              "adults" => reservation.adults,
              "children" => reservation.children,
              "email" => reservation.email,
              "phone" => reservation.phone,
              "notes" => reservation.notes,
              "secret" => reservation.secret,
              "updated_at" => String,
              "created_at" => String
            )
          }
        end

        context "when payment has a payment associated" do
          before do
            create(:reservation_payment, reservation:)
            req
          end

          it { expect(json[:item]).to include("payment" => Hash) }
          it { expect(json[:item]["payment"]).to include("status" => reservation.reload.payment.status) }
          it { expect(json[:item]["payment"]).to include("value" => reservation.reload.payment.value) }
        end

        context "when has stripe authorization associated" do
          before do
            create(:reservation_payment, :stripe_authorization, reservation:)
            req
          end

          it { expect(json[:item]).to include("payment" => Hash) }
          it { expect(json[:item]["payment"]).to include("status" => "authorized") }
          it { expect(json[:item]["payment"]).to include("preorder_type" => "stripe_authorization") }
          it { expect(json[:item]["payment"]).to include("hpp_url" => reservation.reload.payment.do_payment_url) }
          it { expect(json[:item]["payment"]["hpp_url"]).to include("#{reservation.secret}/do_payment") }
          it { expect(json[:item]["payment"]["hpp_url"]).not_to include("https://checkout.stripe.com") }
        end

        context "when has stripe payment associated" do
          before do
            create(:reservation_payment, :stripe_payment, reservation:)
            req
          end

          it { expect(json[:item]).to include("payment" => Hash) }
          it { expect(json[:item]["payment"]).to include("status" => "paid") }
          it { expect(json[:item]["payment"]).to include("preorder_type" => "stripe_payment") }
          it { expect(json[:item]["payment"]).to include("hpp_url" => reservation.reload.payment.do_payment_url) }
          it { expect(json[:item]["payment"]["hpp_url"]).not_to include("https://checkout.stripe.com") }
        end
      end

      context "when secret is invalid" do
        subject { response }

        let(:params) { { secret: "some-invalid-secret" } }

        before { req }

        it_behaves_like NOT_FOUND
      end

      context "when reservation is deleted" do
        subject { response }

        before do
          reservation.deleted!
          req
        end

        it_behaves_like NOT_FOUND
      end
    end
  end
end
