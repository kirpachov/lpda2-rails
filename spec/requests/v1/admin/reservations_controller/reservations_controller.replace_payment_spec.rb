# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request POST /v1/admin/reservations/<id>/replace_payment" do |status: nil, message: nil|
  it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }
  it { expect { req }.not_to(change { Reservation.all.as_json }) }

  it do
    expect { req }.not_to(change { [ReservationPayment.all.as_json, Reservation.all.as_json] })

    expect(json[:message].to_s.downcase).to include(message.to_s.downcase) if message

    expect(json).to include(message: String)

    if status
      expect(response).to have_http_status(status)
    else
      expect(response).not_to have_http_status(:ok)

      expect(response).not_to have_http_status(:internal_server_error)
    end
  end
end

RSpec.shared_examples "successful request POST /v1/admin/reservations/<id>/replace_payment" do
  it do
    expect { req }.not_to(change do
                            [Reservation.count, ReservationPayment.count,
                             ReservationPayment.all.as_json(only: %i[value preorder_type reservation_id])]
                          end)
    expect(json).not_to include(message: String)
    expect(response).to have_http_status(:ok)
  end

  it { expect { req }.to(change { Reservation.all.as_json }) }
  it { expect { req }.to(change { ReservationPayment.all.as_json }) }

  it do
    expect do
      Sidekiq::Testing.inline! do
        req
      end
    end.to(change { Log::ModelChange.where(record_type: "ReservationPayment").count })
  end

  # TODO: uncomment:
  # it { expect { req }.to(change { ReservationPayment.all.as_json(only: %i[hpp_url]) }) }
  # it { expect { req }.to(change { ReservationPayment.all.as_json(only: %i[external_url]) }) }
end

RSpec.describe "POST /v1/admin/reservations/<id>/replace_payment" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }

  let(:default_params) do
    {}
  end

  let!(:reservation) do
    create(:reservation, status: :active).tap do |r|
      create(:reservation_payment, :stripe_authorization, reservation: r, status: :todo)
    end
  end

  let(:reservation_id) { reservation.id }

  before do
    stub_stripe_backend

    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_simple_payment_path)}").to_return do |_request|
      {
        body: File.read(Rails.root.join("spec", "fixtures", "nexi-simple-payment-success-page.html"))
      }
    end
  end

  def req(id: reservation_id, params: default_params, headers: default_headers)
    post "/v1/admin/reservations/#{id}/replace_payment", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"

    it do
      req
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "when reservation does not have email it's fine" do
    before { reservation.update!(email: nil) }

    it do
      Sidekiq::Testing.inline! do
        allow(ReservationMailer).to receive(:with).and_call_original

        req

        expect(ReservationMailer).not_to have_received(:with)
      end
    end

    include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
  end

  context "when common case: reservation has status :active, payment is :expired" do
    let!(:reservation) do
      create(:reservation, status: :active).tap do |r|
        create(:reservation_payment, :stripe_authorization, reservation: r, status: :expired)
      end
    end

    it do
      expect do
        Sidekiq::Testing.inline! do
          req
        end
      end.to(change { Log::ModelChange.where(record_type: "Stripe::PaymentDetails").count })
    end

    it do
      Log::ModelChange.delete_all
      Sidekiq::Testing.inline! do
        req
      end

      expect(Log::ModelChange.where(record_type: "ReservationPayment").pluck(:change_type)).to(match_array(%w[delete
                                                                                                              create]))

      expect(Log::ModelChange.where(record_type: "ReservationPayment").pluck(:record_id).uniq.length).to(eq(2))
      expect(Log::ModelChange.where(record_type: "ReservationPayment",
                                    record_id: reservation.reload.payment.id)).not_to be_empty
      expect(Log::ModelChange.where(record_type: "ReservationPayment",
                                    record_id: reservation.reload.payment.id).pluck(:change_type)).to(eq(["create"]))
    end

    # include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
  end

  context "when reservation does not exist" do
    let(:reservation_id) { 0 }

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment", status: :not_found,
                                                                                       message: "unable to find"
  end

  context "when reservation has status 'deleted'" do
    before { reservation.deleted! }

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment", status: :not_found,
                                                                                       message: "unable to find"
  end

  context "when reservation does not have a payment" do
    let!(:reservation) do
      create(:reservation, status: :active)
    end

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment", status: :unprocessable_entity,
                                                                                       message: "reservation does not have a payment"
  end

  context "when something in the new payment creation process fails, old payment should be restored (or not be deleted)" do
    before do
      allow(CreateReservationPayment).to receive(:run).and_raise(StandardError.new("Payment creation failed"))
      allow(CreateReservationPayment).to receive(:run!).and_raise(StandardError.new("Payment creation failed"))
    end

    include_context "failed request POST /v1/admin/reservations/<id>/replace_payment", status: :internal_server_error,
                                                                                       message: "payment creation failed"
  end

  %i[
    active
    arrived
    cancelled
    noshow
  ].each do |reservation_status|
    # ###############################
    # Here, has success.
    # ###############################
    %i[
      todo
      expired
      refunded
    ].each do |payment_status|
      context "when payment type is :stripe_authorization and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :stripe_authorization, reservation: r, status: payment_status)
          end
        end

        it { expect { req }.not_to(change { reservation.reload.payment.preorder_type }.from("stripe_authorization")) }

        include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :stripe_payment and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :stripe_payment, reservation: r, status: payment_status)
          end
        end

        it { expect { req }.not_to(change { reservation.reload.payment.preorder_type }.from("stripe_payment")) }

        include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :nexi_payment and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :nexi_payment, reservation: r, status: payment_status)
          end
        end

        it { expect { req }.not_to(change { reservation.reload.payment.preorder_type }.from("html_nexi_payment")) }

        include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :nexi_authorization and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :nexi_authorization, reservation: r, status: payment_status)
          end
        end

        it {
          expect { req }.not_to(change do
                                  reservation.reload.payment.preorder_type
                                end.from("html_nexi_authorization"))
        }

        include_context "successful request POST /v1/admin/reservations/<id>/replace_payment"
      end
    end

    # ###############################
    # Here, fails because cannot replace completed payments.
    # ###############################
    %i[
      authorized
      paid
    ].each do |payment_status|
      context "when payment type is :stripe_authorization and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :stripe_authorization, reservation: r, status: payment_status)
          end
        end

        it {
          expect { req }.not_to(change do
                                  reservation.reload.payment.preorder_type
                                end.from("stripe_authorization"))
        }

        include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :stripe_payment and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :stripe_payment, reservation: r, status: payment_status)
          end
        end

        it { expect { req }.not_to(change { reservation.reload.payment.preorder_type }.from("stripe_payment")) }

        include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :nexi_payment and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :nexi_payment, reservation: r, status: payment_status)
          end
        end

        it { expect { req }.not_to(change { reservation.reload.payment.preorder_type }.from("html_nexi_payment")) }

        include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"
      end

      context "when payment type is :nexi_authorization and status is #{payment_status.inspect}, reservation status is #{reservation_status.inspect}" do
        let!(:reservation) do
          create(:reservation, status: reservation_status).tap do |r|
            create(:reservation_payment, :nexi_authorization, reservation: r, status: payment_status)
          end
        end

        it {
          expect { req }.not_to(change do
                                  reservation.reload.payment.preorder_type
                                end.from("html_nexi_authorization"))
        }

        include_context "failed request POST /v1/admin/reservations/<id>/replace_payment"
      end
    end
  end
end
