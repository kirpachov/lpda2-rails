# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "failed request /v1/admin/table_types" do
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

  it { expect { req }.not_to(change(TableType, :count)) }
end

RSpec.shared_examples "successful request /v1/admin/table_types" do
  it do
    req
    expect(response).to have_http_status(:ok)
  end

  it do
    req
    expect(json).not_to include(message: String)
  end

  it { expect { req }.to(change(TableType, :count)) }
end

RSpec.describe "POST /v1/admin/table_types" do
  include_context REQUEST_AUTHENTICATION_CONTEXT

  let(:current_user_root_at) { Time.zone.now }
  let(:default_headers) { auth_headers }
  let(:default_params) do
    { default_people_per_turn: 15, default_price: 10, notes: "Gigi", name: "Luxury 1", description: "Super luxe table" }
  end

  def req(params: default_params, headers: default_headers)
    post "/v1/admin/table_types", headers:, params:
  end

  context "when not authenticated" do
    let(:default_headers) { {} }

    it { expect { req }.not_to(change { TableType.all.as_json }) }

    it_behaves_like "failed request /v1/admin/table_types"

    it do
      req
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when current user is not root" do
    let(:current_user_root_at) { nil }

    it_behaves_like "failed request /v1/admin/table_types"
  end

  context "when creating a basic table type" do
    it_behaves_like "successful request /v1/admin/table_types"

    it { expect { req }.to change { TableType.where(status: :active).count }.by(1) }

    it {
      expect { req }.to change {
                          TableType.where(default_people_per_turn: default_params[:default_people_per_turn]).count
                        }.by(1)
    }

    it { expect { req }.to change { TableType.where(default_price: default_params[:default_price]).count }.by(1) }
    it { expect { req }.to change { TableType.where(notes: default_params[:notes]).count }.by(1) }

    it do
      req
      expect(TableType.last.name).to eq("Luxury 1")
      expect(TableType.last.description).to eq("Super luxe table")
    end
  end

  context "when setting name for each it and en language" do
    let(:default_params) do
      super().merge(
        name: { it: "Luxe it", en: "luxe en" },
        description: { it: "Super luxe table it", en: "Super luxe table en" }
      )
    end

    it_behaves_like "successful request /v1/admin/table_types"

    it do
      req
      I18n.with_locale(:it) do
        expect(TableType.last.name).to eq("Luxe it")
        expect(TableType.last.description).to eq("Super luxe table it")
      end

      I18n.with_locale(:en) do
        expect(TableType.last.name).to eq("luxe en")
        expect(TableType.last.description).to eq("Super luxe table en")
      end
    end
  end

  context "default_people_per_turn cannot be 0" do
    let(:default_params) do
      super().merge(default_people_per_turn: 0)
    end

    it_behaves_like "failed request /v1/admin/table_types"
  end

  context "default_price can be 0" do
    let(:default_params) do
      super().merge(default_price: 0)
    end

    it_behaves_like "successful request /v1/admin/table_types"
  end

  %w[default_people_per_turn default_price].each do |param_name|
    [nil, ""].each do |value|
      context "when #{param_name} is blank: #{value.inspect}" do
        let(:default_params) do
          super().merge(param_name => value)
        end

        it_behaves_like "failed request /v1/admin/table_types"
      end
    end
  end
end
