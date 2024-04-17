# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GET /v1/admin/users" do
  let(:users) { create_list(:user, 3, :with_fullname) }

  let(:headers) { {} }
  let(:params) { {} }

  def req
    get users_path, headers: headers, params: params
  end

  describe "when making basic request" do
    subject { response }

    before do
      users
      req
      response
    end

    it { is_expected.to have_http_status(:ok) }
    it { expect(json).to include(items: Array, metadata: Hash) }
    it { expect(json[:items]).not_to be_empty }
    it { expect(json[:items]).to all(include(id: Integer, email: String, fullname: String, created_at: String, updated_at: String)) }
    it { expect(json[:items][0]).not_to include(:enc_otp_key) }
    it { expect(json[:items][0]).not_to include(:password) }
    it { expect(json[:items][0]).not_to include(:password_digest) }
    it { expect(json[:items][0]).not_to include(:username) }
    it { expect(json[:items][0]).not_to include(:failed_attempts) }
    it { expect(json[:items][0]).not_to include(:root_at) }
  end

  context "when filtering by query" do
    subject! do
      users
      req
      response
    end

    let(:users) do
      [
        create(:user, email: "userEmailFirst@example.com", fullname: "User Fullname First"),
        create(:user, email: "userEmailSecond@example.com", fullname: "User Fullname Second"),
      ]
    end

    context "when looking for a user by email" do
      let(:params) { { query: "second@example.com" } }

      it "returns the user with the email" do
        req
        expect(json[:items].size).to eq(1)
        expect(json[:items][0][:email]).to eq("userEmailSecond@example.com")
      end
    end

    context "when looking for a user by fullname" do
      let(:params) { { query: "Fullname First" } }

      it "returns the user with the fullname" do
        req
        expect(json[:items].size).to eq(1)
        expect(json[:items][0][:fullname]).to eq("User Fullname First")
      end
    end
  end

  context "when filtering by id" do
    before do
      users
      req
      response
    end

    let(:users) { create_list(:user, 3) }

    context "when looking for first user" do
      let(:params) { { id: users.first.id } }

      it "returns the user with the id" do
        expect(json[:items].size).to eq(1)
        expect(json[:items][0][:id]).to eq(users.first.id)
      end
    end

    context "when looking for the last user" do
      let(:params) { { id: users.last.id } }

      it "returns the user with the id" do
        expect(json[:items].size).to eq(1)
        expect(json[:items][0][:id]).to eq(users.last.id)
      end
    end

    context "when looking for a non-existent user" do
      let(:params) { { id: 0 } }

      it "returns an empty array" do

        expect(json[:items]).to be_empty
      end
    end
  end
end
