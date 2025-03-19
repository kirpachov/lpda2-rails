# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed refund_payment" do
  it do
    req
    expect(response).not_to have_http_status(:ok)
  end

  it do
    req
    expect(json).to include(message: String)
  end

  it { expect { req }.not_to(change { reservation.payment.status }) }
  it { expect { req }.not_to(change { Reservation.all.as_json }) }
  it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }
  # it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
  # it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation).count }.by(1)) }
end

RSpec.describe "POST /v1/admin/reservations/<id>/refund_payment" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:nexi_response) do
    {
      esito: "OK",
      idOperazione: reservation.payment.external_id,
      timeStamp: Time.zone.now.to_i * 1000,
      mac: SecureRandom.hex
    }
  end
  let(:default_params) do
    {}
  end

  let(:reservation) do
    create(:reservation).tap do |reservation|
      create(:reservation_payment, reservation:, status: :paid,
                                   preorder_type: %w[html_nexi_payment html_nexi_authorization].sample)
    end
  end

  before do
    reservation
    current_user
    current_user.update!(root_at: Time.zone.now)
  end

  def stub_nexi_server
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_refund_payment_path)}").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: nexi_response.to_json
      }
    end
  end

  def req(id: reservation.id, params: default_params, headers: default_headers)
    stub_nexi_server
    post "/v1/admin/reservations/#{id}/refund_payment", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { Reservation.all.as_json }) }
    it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "when current user is not root" do
    before { current_user.update!(root_at: nil) }

    it { expect { req }.not_to(change { Reservation.all.as_json }) }
    it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }

    it do
      req
      expect(response).to have_http_status(:forbidden)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "basic" do
    it do
      req
      expect(response).to have_http_status(:ok)
    end

    it do
      req
      expect(json).not_to include(message: String)
    end

    it { expect { req }.to(change { reservation.reload.payment.status }.from("paid").to("refunded")) }
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation).count }.by(1)) }

    # TODO: send email to customer
    pending "should have sent emails to customer"
  end

  context "when reservation is deleted" do
    before { reservation.deleted! }

    it_behaves_like "failed refund_payment"
    it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    it { expect { req }.not_to(change { Nexi::HttpRequest.where(record: reservation).count }) }
  end

  context "when payment has status 'todo" do
    before { reservation.payment.update!(status: :todo) }

    it_behaves_like "failed refund_payment"
    it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    it { expect { req }.not_to(change { Nexi::HttpRequest.where(record: reservation).count }) }
  end

  context "when nexi api(s) return blank response" do
    let(:nexi_response) { {} }

    it_behaves_like "failed refund_payment"
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation).count }.by(1)) }
  end

  context "when nexi api(s) return invalid response" do
    let(:nexi_response) { { esito: "KO" } }

    it_behaves_like "failed refund_payment"
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation).count }.by(1)) }
  end
end
