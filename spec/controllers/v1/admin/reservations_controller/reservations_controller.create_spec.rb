# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "POST #create" do
    let(:params) { attributes_for(:reservation) }

    it { expect(instance).to respond_to(:create) }
    it { expect(described_class).to route(:post, "/v1/admin/reservations").to(action: :create, format: :json) }

    def req(data = params)
      post :create, params: data
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      context "basic" do
        it { expect { req }.to change(Reservation, :count).by(1) }

        it "returns reservation info" do
          req
          expect(parsed_response_body).to include(item: Hash)

          expect(parsed_response_body[:item]).to include(
            fullname: String,
            datetime: String,
            status: String,
            secret: String,
            adults: Integer,
            children: Integer,
            table: String,
            notes: String,
            email: String,
            phone: String,
            other: Hash,
            created_at: String,
            updated_at: String,
            id: Integer
          )
          expect(response).to have_http_status(:ok)
        end
      end

      context "when people is greater than max_people_per_reservation" do
        let(:adults) { Setting[:max_people_per_reservation].to_i + 1 }

        it "returns 200" do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end
      end

      # MINIMUM REQUIRED INFO: fullname, datetime, adults.
      ["Anne Marie", "Luigi"].each do |fullname|
        ["2024-10-12 19:00", "2024-12-25 21:00"].each do |datetime|
          [1, 2, 3].each do |adults|
            context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}}" do
              let(:params) { { fullname:, datetime:, adults: } }

              it { expect { req }.to change(Reservation, :count).by(1) }

              it "returns provided info" do
                req
                expect(parsed_response_body).to include(item: Hash)
                expect(parsed_response_body[:item]).to include(fullname:, adults:)
                expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
                expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
                expect(response).to have_http_status(:ok)
              end
            end

            [201, "204 fuori"].each do |table|
              ["bambini", "bella vita"].each do |notes|
                ["sa@ba", "gi@gi"].each do |email|
                  ["123 333 333", "456 666 666"].each do |phone|
                    context "when providing {fullname: #{fullname.inspect}, datetime: #{datetime.inspect}, adults: #{adults}, table: #{table.inspect}, notes: #{notes.inspect}, email: #{email.inspect}, phone: #{phone.inspect}}" do
                      let(:params) { { fullname:, datetime:, adults:, table:, notes:, email:, phone: } }

                      it "returns provided info" do
                        expect { req }.to change(Reservation, :count).by(1)
                        expect(parsed_response_body).to include(item: Hash)
                        expect(parsed_response_body[:item]).to include(fullname:, adults:, email:, table: table.to_s,
                                                                       notes:)
                        expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").first)
                        expect(parsed_response_body.dig(:item, :datetime)).to include(datetime.split(" ").last)
                        expect(response).to have_http_status(:ok)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
