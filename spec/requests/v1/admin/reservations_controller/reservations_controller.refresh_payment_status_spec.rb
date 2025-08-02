# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed refresh_payment_status" do
  it do
    req
    expect(response).not_to have_http_status(:ok)
  end

  it do
    req
    expect(response).not_to have_http_status(:internal_server_error)
  end

  it do
    req
    expect(json).to include(message: String)
  end

  it { expect { req }.not_to(change { reservation.payment.status }) }
  it { expect { req }.not_to(change { Reservation.all.as_json }) }
  it { expect { req }.not_to(change { ReservationPayment.all.as_json }) }
end

RSpec.describe "POST /v1/admin/reservations/<id>/refresh_payment_status" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:default_headers) { auth_headers }
  let(:nexi_response) do
    {
      mac: "1ed21acd6bbbf641e6a599eeb15d027861715265",
      esito: "OK",
      report: [{
        stato: "Annullato",
        dataTransazione: "2024-11-20 23:54:38.0",
        codiceTransazione: reservation.payment.external_id
        # ... other fields here
      }],
      timeStamp: "1732145720139",
      idOperazione: "160209354"
    }
  end
  let(:default_params) do
    {}
  end

  let(:reservation) do
    create(:reservation).tap do |reservation|
      create(:reservation_payment, reservation:, status: :paid)
    end
  end

  before do
    reservation
    current_user
    current_user.update!(root_at: Time.zone.now)
  end

  def stub_nexi_server
    stub_request(:post,
                 "#{Config.app.dig!(:nexi_api_url)}/#{Config.app.dig!(:nexi_order_status_path)}").to_return do |_request|
      {
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: nexi_response.to_json
      }
    end
  end

  def req(id: reservation.id, params: default_params, headers: default_headers)
    stub_nexi_server
    post "/v1/admin/reservations/#{id}/refresh_payment_status", headers:, params:
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
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation.payment).count }.by(1)) }
  end

  context "when reservation is deleted" do
    before { reservation.deleted! }

    it_behaves_like "failed refresh_payment_status"
    it { expect { req }.not_to(change { Nexi::HttpRequest.count }) }
    it { expect { req }.not_to(change { Nexi::HttpRequest.where(record: reservation.payment).count }) }
  end

  [
    "Contabilizzato",
    "Contabilizzato Parz.",
    "Autorizzato"
  ].each do |nexi_success_code|
    %w[
      todo
      refunded
    ].each do |payment_initial_status|
      context "when payment has status '#{payment_initial_status}' but nexi api says it's okay: returns #{nexi_success_code.inspect}" do
        let(:nexi_response) do
          {
            mac: "1ed21acd6bbbf641e6a599eeb15d027861715265",
            esito: "OK",
            report: [{
              stato: nexi_success_code,
              dataTransazione: "2024-11-20 23:54:38.0",
              codiceTransazione: reservation.payment.external_id
              # ... other fields here
            }],
            timeStamp: "1732145720139",
            idOperazione: "160209354"
          }
        end

        before { reservation.payment.update!(status: payment_initial_status) }

        it { expect { req }.to(change { reservation.reload.payment.status }.from(payment_initial_status).to("paid")) }
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it do
          req
          expect(json).not_to include(message: String)
        end
      end
    end
  end

  [
    "Annullato",
    "Rimborsato",
    "Rimborsato Parz."
  ].each do |nexi_success_code|
    %w[
      paid
      todo
    ].each do |payment_initial_status|
      context "when payment has status '#{payment_initial_status}' but nexi api says refund was made: returns #{nexi_success_code.inspect}" do
        let(:nexi_response) do
          {
            mac: "1ed21acd6bbbf641e6a599eeb15d027861715265",
            esito: "OK",
            report: [{
              stato: nexi_success_code,
              dataTransazione: "2024-11-20 23:54:38.0",
              codiceTransazione: reservation.payment.external_id
              # ... other fields here
            }],
            timeStamp: "1732145720139",
            idOperazione: "160209354"
          }
        end

        before { reservation.payment.update!(status: payment_initial_status) }

        it {
          expect { req }.to(change do
                              reservation.reload.payment.status
                            end.from(payment_initial_status).to("refunded"))
        }

        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

        it do
          req
          expect(response).to have_http_status(:ok)
        end

        it do
          req
          expect(json).not_to include(message: String)
        end
      end
    end
  end

  context "when nexi api(s) return blank response" do
    let(:nexi_response) { {} }

    it_behaves_like "failed refresh_payment_status"
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation.payment).count }.by(1)) }
  end

  context "when nexi api(s) return invalid response" do
    let(:nexi_response) { { esito: "KO" } }

    it_behaves_like "failed refresh_payment_status"
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation.payment).count }.by(1)) }
  end

  context "when nexi apis return partially-valid response: value of 'report' is an array that does not include same order id" do
    let(:nexi_response) do
      {
        mac: "1ed21acd6bbbf641e6a599eeb15d027861715265",
        esito: "OK",
        report: [{
          stato: "Contabilizzato",
          dataTransazione: "2024-11-20 23:54:38.0",
          codiceTransazione: SecureRandom.uuid
        }],
        timeStamp: "1732145720139",
        idOperazione: "160209354"
      }
    end

    it_behaves_like "failed refresh_payment_status"
    it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
    it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation.payment).count }.by(1)) }
  end

  context "when nexi responds with 'order not found'" do
    let(:nexi_response) do
      {
        "esito" => "KO",
        "idOperazione" => "1556929671",
        "timeStamp" => "1732363212583",
        "mac" => "221068eab6c869d4cf8a77181d2219fce8161dc0",
        "errore" => { "codice" => 2, "messaggio" => "Nessun ordine trovato" }
      }
    end

    %w[
      paid
      refunded
    ].each do |status|
      context "when payment has status #{status.inspect} is not okay." do
        before { reservation.payment.update!(status:) }

        it_behaves_like "failed refresh_payment_status"
        it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }
        it { expect { req }.to(change { Nexi::HttpRequest.where(record: reservation.payment).count }.by(1)) }
      end
    end

    context "when payment has status 'todo' is okay: means that user did not proceed with payment" do
      before { reservation.payment.todo! }

      it do
        expect { req }.not_to(change { reservation.reload.payment.status }.from("todo"))
      end

      it { expect { req }.to(change { Nexi::HttpRequest.count }.by(1)) }

      it do
        req
        expect(response).to have_http_status(:ok)
      end

      it do
        req
        expect(json).not_to include(message: String)
      end
    end
  end
end
