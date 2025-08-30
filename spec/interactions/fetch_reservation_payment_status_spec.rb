# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "when successful run FetchReservationPaymentStatus interaction" do
  it { expect(call).to be_valid }
  it { expect { call }.to(change(Log::StripeEvent, :count)) }
  it { expect { call }.not_to(change(ReservationPayment, :count)) }
  it { expect { call }.not_to(change(Reservation, :count)) }
end

RSpec.shared_examples "when failed run FetchReservationPaymentStatus interaction" do
  it { expect(call).not_to be_valid }
  it { expect(call.errors).not_to be_empty }
  # it { expect { call }.to(change(Log::StripeEvent, :count)) }
  it { expect { call }.not_to(change { ReservationPayment.all.as_json }) }
  it { expect { call }.not_to(change { Reservation.all.as_json }) }
end

RSpec.describe FetchReservationPaymentStatus, type: :interaction do
  subject(:call) do
    stub
    described_class.run(reservation_payment:)
  end

  let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }
  let(:reservation_payment_external_id) { "PO123321" }
  let!(:reservation) { create(:reservation) }
  let(:preorder_type) { :html_nexi_authorization }
  let!(:reservation_payment) do
    create(:reservation_payment, preorder_type:, reservation:, external_id: reservation_payment_external_id)
  end

  let(:stub_response) do
    {
      status: 200,
      body: File.read(
        response_file
      ).gsub("CODICE_TRANSAZIONE", reservation_payment_external_id)
    }
  end

  let(:stub) do
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
      stub_response
    end
  end

  include_context TESTS_OPTIMIZATIONS_CONTEXT

  it { expect(reservation_payment).to be_valid }
  it { expect(call.errors).to be_empty }

  context "when payment gateway is 'stripe'" do
    before do
      stub_stripe_backend
    end

    let!(:reservation_payment) do
      create(:reservation_payment, %i[stripe_payment stripe_authorization].sample, reservation:, status: :todo)
    end

    context "when reservation_payment does not have stripe_payment_details" do
      before do
        reservation_payment.stripe_payment_details.destroy
      end

      it_behaves_like "when failed run FetchReservationPaymentStatus interaction"
    end

    # checkout_session.status: expired; payment_intent.status: , checkout_session.mode: payment
    context "when expired checkout session for payment" do
      before do
        reservation_payment.update!(
          preorder_type: "stripe_payment"
        )

        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: nil
        )

        stub_stripe_backend(
          responses: {
            get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_expired],
          }
        )
      end

      it { expect(reservation_payment.stripe_payment_details.payment_intent).to be_nil }
      it { expect(reservation_payment.stripe_payment_details.payment_intent_id).to be_nil }

      context "when initially payment status was 'todo'" do
        before do
          reservation_payment.update!(status: "todo")
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        it { expect { call }.not_to(change { reservation_payment.reload.status }.from("todo")) }
      end
    end

    context "when payment_intent has status 'succeeded' but refund has also status 'succeeded', should mark as refunded" do
      before do
        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: StubStripeBackendHelper::PAYMENT_INTENT_ID,
          refund_id: StubStripeBackendHelper::REFUND_ID
        )
        reservation_payment.update!(status: "paid")
        stub_stripe_backend(
          responses: {
            get_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success_succeeded],
            get_refund: StubStripeBackendHelper::ENDPOINT_RESPONSES_BODY[:get_refund]
          }
        )
      end

      it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

      it { expect { call }.to(change { reservation_payment.reload.status }.from("paid").to("refunded")) }
    end

    %w[
      todo
      authorized
      paid
      refunded
    ].each do |initial_payment_status|
      context "when refund_id is set. initial_payment_status=#{initial_payment_status.inspect}" do
        before do
          reservation_payment.stripe_payment_details.update!(
            refund_id: StubStripeBackendHelper::REFUND_ID
          )

          reservation_payment.update!(status: initial_payment_status)
          stub_stripe_backend
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        if initial_payment_status != "refunded"
          it {
            expect { call }.to(change do
                                 reservation_payment.reload.status
                               end.from(initial_payment_status).to("refunded"))
          }
        end

        it do
          call
          expect(reservation_payment.reload.status).to eq("refunded")
        end
      end
    end

    context "when reservation_payment has status 'todo' and stripe session has status 'open': won't change anything" do
      before do
        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: nil
        )

        reservation_payment.update!(status: "todo")
        stub_stripe_backend(
          responses: {
            get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_open]
            # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
          }
        )
      end

      it_behaves_like "when successful run FetchReservationPaymentStatus interaction"
      it { expect { call }.not_to(change { reservation_payment.reload.as_json }) }
      it { expect { call }.not_to(change { reservation_payment.reload.status }.from("todo")) }
    end

    %w[
      paid
      authorized
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status '#{initial_payment_status}' and stripe session has status 'open': will be updated to 'todo'" do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: nil
          )
          reservation_payment.update!(status: initial_payment_status)
          stub_stripe_backend(
            responses: {
              get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_open]
              # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"
        it { expect { call }.to(change { reservation_payment.reload.status }.from(initial_payment_status).to("todo")) }
      end
    end

    %w[
      todo
      paid
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status '#{initial_payment_status}' but stripe session has status 'complete' (without payment intent)" do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: nil
          )

          reservation_payment.update!(status: initial_payment_status)

          stub_stripe_backend(
            responses: {
              get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_authorized]
              # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        it {
          expect { call }.to(change do
                               reservation_payment.reload.status
                             end.from(initial_payment_status).to("authorized"))
        }
      end
    end

    context "when reservation_payment has status 'authorized' but stripe session has status 'complete' (without payment intent)" do
      before do
        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: nil
        )

        reservation_payment.update!(status: "authorized")

        stub_stripe_backend(
          responses: {
            get_checkout_session: StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_authorized]
            # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
          }
        )
      end

      it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

      it {
        expect { call }.not_to(change do
                                 reservation_payment.reload.status
                               end.from("authorized"))
      }
    end

    %w[
      todo
      authorized
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status 'authorized' but stripe session has status 'complete' (with payment intent)" do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: nil
          )

          reservation_payment.update!(status: initial_payment_status)

          stub_stripe_backend(
            responses: {
              get_checkout_session: File.read(
                Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_with_payment_intent.json")
              )
              # StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_paid]
              # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        it {
          expect { call }.to(change do
                               reservation_payment.reload.status
                             end.from(initial_payment_status).to("paid"))
        }
      end
    end

    context "when reservation_payment has status 'paid' but stripe session has status 'complete' (with payment intent)" do
      before do
        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: nil
        )

        reservation_payment.update!(status: "paid")

        stub_stripe_backend(
          responses: {
            get_checkout_session: File.read(
              Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_with_payment_intent.json")
            )
            # StubStripeBackendHelper::STRIPE_RESPONSES[:checkout_session_retrieve_success_paid]
            # retrieve_payment_intent: StubStripeBackendHelper::STRIPE_RESPONSES[:payment_intent_retrieve_success]
          }
        )
      end

      it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

      it {
        expect { call }.not_to(change do
                                 reservation_payment.reload.status
                               end.from("paid"))
      }
    end

    context "when reservation_payment has status 'paid' and stripe session is complete with external payment intent" do
      before do
        reservation_payment.stripe_payment_details.update!(
          payment_intent_id: StubStripeBackendHelper::PAYMENT_INTENT_ID
        )

        reservation_payment.update!(status: "paid")

        stub_stripe_backend(
          responses: {
            get_checkout_session: File.read(
              Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_authorized.json")
            ),
            retrieve_payment_intent: File.read(
              Rails.root.join("spec/fixtures/stripe/payment_intent/retrieve_success.json")
            )
          }
        )
      end

      it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

      it {
        expect { call }.not_to(change do
                                 reservation_payment.reload.status
                               end.from("paid"))
      }
    end

    %w[
      todo
      authorized
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status '#{initial_payment_status}' and stripe session is complete with external payment intent" do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: StubStripeBackendHelper::PAYMENT_INTENT_ID
          )

          reservation_payment.update!(status: initial_payment_status)

          stub_stripe_backend(
            responses: {
              get_checkout_session: File.read(
                Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_authorized.json")
              ),
              retrieve_payment_intent: File.read(
                Rails.root.join("spec/fixtures/stripe/payment_intent/retrieve_success.json")
              )
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        it {
          expect { call }.to(change do
                               reservation_payment.reload.status
                             end.from(initial_payment_status).to("paid"))
        }
      end
    end

    %w[
      todo
      authorized
      paid
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status '#{initial_payment_status}' and stripe session is complete with external payment intent, but payment intent is canceled" do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: StubStripeBackendHelper::PAYMENT_INTENT_ID
          )

          reservation_payment.update!(status: initial_payment_status)

          stub_stripe_backend(
            responses: {
              get_checkout_session: File.read(
                Rails.root.join("spec/fixtures/stripe/checkout_session/retrieve_success_authorized.json")
              ),
              retrieve_payment_intent: File.read(
                Rails.root.join("spec/fixtures/stripe/payment_intent/retrieve_success_canceled.json")
              )
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        if initial_payment_status != "refunded"
          it {
            expect { call }.to(change do
                                 reservation_payment.reload.status
                               end.from(initial_payment_status).to("refunded"))
          }
        end

        it do
          call
          expect(reservation_payment.reload.status).to eq("refunded")
        end
      end
    end

    %w[
      todo
      authorized
      paid
      refunded
    ].each do |initial_payment_status|
      context "when reservation_payment has status '#{initial_payment_status}' and stripe session is open with 'unpaid' payment." do
        before do
          reservation_payment.stripe_payment_details.update!(
            payment_intent_id: nil
          )

          reservation_payment.update!(status: initial_payment_status)

          stub_stripe_backend(
            responses: {
              get_checkout_session: File.read(
                Rails.root.join("spec/fixtures/stripe/checkout_session/success_payment_todo.json")
              )
              # retrieve_payment_intent: File.read(
              #   Rails.root.join("spec/fixtures/stripe/payment_intent/success_payment_todo.json")
              # )
            }
          )
        end

        it_behaves_like "when successful run FetchReservationPaymentStatus interaction"

        if initial_payment_status != "todo"
          it {
            expect { call }.to(change do
                                 reservation_payment.reload.status
                               end.from(initial_payment_status).to("todo"))
          }
        end

        it do
          call
          expect(reservation_payment.reload.status).to eq("todo")
        end
      end
    end
  end

  context "when authorization, and its already in status 'paid' (user already charged)" do
    let(:preorder_type) { :html_nexi_authorization }

    before do
      reservation_payment.update(status: "paid")
    end

    it { expect { subject }.not_to(change { reservation_payment.reload.status }) }
    it { expect { subject }.not_to(change { reservation_payment.reload.as_json }) }
  end

  %w[html_nexi_payment html_nexi_authorization].each do |preorder_type|
    context "when preorder_type is #{preorder_type.inspect}" do
      let(:preorder_type) { preorder_type }

      context "when nexi returns success" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-success.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          if preorder_type == "html_nexi_payment"
            expect { subject }.to(change do
                                    reservation_payment.reload.status
                                  end.from("todo").to("paid"))
          end
          if preorder_type == "html_nexi_authorization"
            expect { subject }.to(change do
                                    reservation_payment.reload.status
                                  end.from("todo").to("authorized"))
          end
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end

      context "when nexi returns not paid" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-not-paid.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          expect { subject }.not_to(change { reservation_payment.reload.status }.from("todo"))
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end

      context "when nexi returns refunded" do
        let(:response_file) { Rails.root.join("spec/fixtures/nexi-order-status-refunded.json") }

        it { expect(reservation_payment).to be_valid }
        it { expect(call.errors).to be_empty }

        it do
          expect { subject }.to(change { reservation_payment.reload.status }.from("todo").to("refunded"))
          expect { described_class.run(reservation_payment:) }.not_to(change { reservation_payment.reload.status })
        end
      end
    end
  end
end
