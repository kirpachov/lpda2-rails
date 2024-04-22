# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST /v1/admin/users" do
  before do
    # TODO remove this and authenticate user
    create(:user)
  end

  let(:fullname) { Faker::Lorem.name }
  let(:email) { Faker::Internet.email }

  let(:headers) { {} }
  let(:params) { { fullname:, email: } }

  def req
    post users_path, headers: headers, params: params
  end

  describe "when making a basic request" do
    subject { response }

    before { req }

    it { is_expected.to have_http_status(:ok) }
    it { expect(json[:item]).to include(id: Integer, email: email, fullname: fullname, created_at: String, updated_at: String) }
  end

  context "when fullname is blank" do
    subject { response }
    let(:fullname) { nil }

    before { req }

    it { is_expected.to have_http_status(:ok) }
    it { expect(json[:item]).to include(id: Integer, email: email, fullname: nil, created_at: String, updated_at: String) }
  end

  context "when can_root is true" do
    subject { response }
    let(:can_root) { true }
    let(:params) { { fullname:, email:, can_root: } }

    before { req }

    it { is_expected.to have_http_status(:ok) }

    it { expect(json[:item]).to include(id: Integer, can_root: true) }
  end

  context "when can_root is false" do
    subject { response }
    let(:can_root) { false }
    let(:params) { { fullname:, email:, can_root: } }

    before { req }

    it { is_expected.to have_http_status(:ok) }

    it { expect(json[:item]).to include(id: Integer, can_root: false) }
  end

  context "when can_root is blank" do
    subject { response }
    let(:can_root) { nil }
    let(:params) { { fullname:, email:, can_root: } }

    before { req }

    it { is_expected.to have_http_status(:ok) }

    it { expect(json[:item]).to include(id: Integer, can_root: false) }
  end
end
