# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PATCH /v1/admin/settings/:key" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:headers) { auth_headers }
  let(:params) { { value: } }

  let(:value) { "en" }
  let(:key) { "default_language" }

  def req(k = key, p = params, h = headers)
    patch "#{settings_path}/#{k}", headers: h, params: p
  end

  before { Setting.create_missing }

  context "when not authenticated" do
    let(:headers) { {} }

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end

    it do
      req
      expect(json).to include(message: String)
    end
  end

  context "when authenticated" do
    context "when setting invalid default_language" do
      let(:value) { "invalid" }
      let(:key) { "default_language" }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end
    end

    context "when settings exist" do
      subject { json }

      before { req }

      it do
        expect(response).to be_successful
      end

      it { is_expected.to be_a(Hash) }
      it { is_expected.not_to be_empty }
    end

    context "when setting default_language to 'en'" do
      let(:value) { "en" }
      let(:key) { "default_language" }

      before do
        Setting.find_by(key: :default_language).update!(value: :it)
      end

      it { expect { req }.to(change { Setting.find_by(key: :default_language).value }.from("it").to("en")) }
      it { expect { req }.to(change { Setting.find_by(key: :default_language).updated_at }) }

      it { expect { req }.not_to(change { Setting.where.not(key: :default_language).order(:id).pluck(:updated_at) }) }

      it do
        req
        expect(json["value"]).to eq("en")
      end

      it do
        req
        expect(json["key"]).to eq("default_language")
      end

      it do
        req
        expect(json).to include(:key, :value, :require_root, :updated_at)
      end
    end

    context "when setting default_language to 'it'" do
      let(:value) { "it" }
      let(:key) { "default_language" }

      before do
        Setting.find_by(key: :default_language).update!(value: :en)
      end

      it { expect { req }.to(change { Setting.find_by(key: :default_language).value }.from("en").to("it")) }
      it { expect { req }.to(change { Setting.find_by(key: :default_language).updated_at }) }

      it { expect { req }.not_to(change { Setting.where.not(key: :default_language).order(:id).pluck(:updated_at) }) }

      it do
        req
        expect(json["value"]).to eq("it")
      end

      it do
        req
        expect(json["key"]).to eq("default_language")
      end

      it do
        req
        expect(json).to include(:key, :value, :require_root, :updated_at)
      end
    end

    context "when unknown key" do
      let(:key) { "unknown" }

      it do
        req
        expect(response).to have_http_status(:not_found)
      end

      it do
        req
        expect(json).to include(message: String)
      end
    end

    context "when updating email_contacts to a valid json: will update and return 200" do
      let(:value) do
        {
          "address" => "Some addr",
          "email" => "email@laportadacqua.com",
          "phone" => "+39 041 241 2124",
          "whatsapp_number" => "+39 041 241 2124",
          "whatsapp_url" => "https://wa.me/+390412412124",
          "facebook_url" => "https://www.facebook.com/Laportadacqua",
          "instagram_url" => "https://www.instagram.com/laportadacqua",
          "tripadvisor_url" => "https://www.tripadvisor.it/Restaurant_Review-g187870-d1735599-Reviews-La_Porta_D_Acqua-Venice_Veneto.html",
          "homepage_url" => "https://laportadacqua.com",
          "google_url" => "https://g.page/laportadacqua?share"
        }
      end

      let(:key) { "email_contacts" }
      let(:params) { { value: value.to_json } }

      it do
        req
        expect(response).to be_successful
      end

      it do
        req
        expect(json["value"]).to eq(value)
      end

      it do
        req
        expect(json["key"]).to eq("email_contacts")
      end

      it do
        expect { req }.to(change { Setting.find_by(key: :email_contacts).reload.value }.to(value))
      end
    end

    context "when updating email_contacts to a valid json but some keys are missing: won't update and will return 422" do
      let(:value) do
        {
          # address IS MISSING.
          # "address" => "Some addr",
          "email" => "email@laportadacqua.com",
          "phone" => "+39 041 241 2124",
          "whatsapp_number" => "+39 041 241 2124",
          "whatsapp_url" => "https://wa.me/+390412412124",
          "facebook_url" => "https://www.facebook.com/Laportadacqua",
          "instagram_url" => "https://www.instagram.com/laportadacqua",
          "tripadvisor_url" => "https://www.tripadvisor.it/Restaurant_Review-g187870-d1735599-Reviews-La_Porta_D_Acqua-Venice_Veneto.html",
          "homepage_url" => "https://laportadacqua.com",
          "google_url" => "https://g.page/laportadacqua?share"
        }
      end

      let(:key) { "email_contacts" }
      let(:params) { { value: value.to_json } }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        req
        expect(json).to include(message: String)
      end

      it do
        req
        expect(json).to include(message: /address/)
      end

      it do
        expect { req }.not_to(change { Setting.find_by(key: :email_contacts).reload.value })
      end
    end

    context "when updating email_contacts to an empty json: won't update and will return 422" do
      let(:value) { {} }

      let(:key) { "email_contacts" }
      let(:params) { { value: value.to_json } }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        expect { req }.not_to(change { Setting.find_by(key: :email_contacts).reload.value })
      end
    end

    context "when updating email_contacts to nil: won't update and will return 422" do
      let(:value) { nil }

      let(:key) { "email_contacts" }
      let(:params) { { value: } }

      it do
        req
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it do
        expect { req }.not_to(change { Setting.find_by(key: :email_contacts).reload.value })
      end
    end
  end
end
