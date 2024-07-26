# frozen_string_literal: true

require "rails_helper"

RESERVATION_TEST_STRUCTURE = "RESERVATION_TEST_STRUCTURE"
RSpec.shared_context RESERVATION_TEST_STRUCTURE do |options = {}|
  it "has valid structure" do
    expect(subject).to be_a(Hash)
    expect(subject).to include(id: Integer, created_at: String, updated_at: String, datetime: String, adults: Integer,
                               children: Integer, status: String)
  end

  # true => check presence
  # false => check absence
  # String => check exact value
  %i[phone email notes].each do |field|
    if options[field] == true
      it "has #{field.inspect}" do
        expect(subject).to include(field.to_sym => String)
      end
    elsif options[field] == false
      it "does not have #{field}" do
        expect(subject[field].to_s).to be_blank
      end
    elsif options[field].is_a?(String)
      it "has #{field.inspect} = #{options[field].inspect}" do
        expect(subject).to include(field.to_sym => options[field])
      end
    end
  end
end

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT

  let(:instance) { described_class.new }

  let(:user) { create(:user) }

  describe "GET #index" do
    it { expect(instance).to respond_to(:index) }
    it { expect(described_class).to route(:get, "/v1/admin/reservations").to(action: :index, format: :json) }

    def req(params = {})
      get :index, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "basic" do
        subject { response }

        before do
          create(:reservation)
          req
        end

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
        end

        context "response[:items][0]" do
          subject { parsed_response_body[:items][0] }

          it_behaves_like RESERVATION_TEST_STRUCTURE, phone: true, email: true, notes: true
        end
      end

      context "when filtering by status, should return all reservations with that status" do
        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
        end

        %w[active noshow cancelled].each do |status|
          context "when filtering by status: #{status.inspect}" do
            subject { response }

            before { req(status:) }

            it { is_expected.to have_http_status(:ok) }

            context "response" do
              subject { parsed_response_body }

              it { is_expected.to be_a(Hash) }
              it { is_expected.to include(items: Array, metadata: Hash) }
              it { expect(parsed_response_body[:items].count).to eq 1 }
            end

            context "response[:items]" do
              subject { parsed_response_body[:items] }

              it { is_expected.to all(include(status:)) }
            end
          end
        end
      end

      context "filtering by invalid date" do
        it "ignores param" do
          req(date: "null")
          expect(parsed_response_body).to include(items: Array, metadata: Hash)
          expect(response).to have_http_status(:ok)

          req(date: "")
          expect(parsed_response_body).to include(items: Array, metadata: Hash)
          expect(response).to have_http_status(:ok)

          req(date: "banana")
          expect(parsed_response_body).to include(items: Array, metadata: Hash)
          expect(response).to have_http_status(:ok)

          req(date: nil)
          expect(parsed_response_body).to include(items: Array, metadata: Hash)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when not filtering by status, should return all except deleted" do
        subject { response }

        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
          req
        end

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 3 }
        end

        context "response[:items]" do
          subject { parsed_response_body[:items] }

          it {
            expect(subject).to all(include(status: "active").or(include(status: "noshow")).or(include(status: "cancelled")))
          }

          it { expect(subject.count).to eq 3 }
        end
      end

      context "when filtering by statuses array" do
        subject { response }

        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
          req(status: %w[active noshow])
        end

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 2 }
        end

        context "response[:items]" do
          subject { parsed_response_body[:items] }

          it { is_expected.to all(include(status: "active").or(include(status: "noshow"))) }
          it { expect(subject.count).to eq 2 }
        end
      end

      context "when filtering by statuses string comma separated" do
        subject { response }

        before do
          create(:reservation, status: :active)
          create(:reservation, status: :deleted)
          create(:reservation, status: :noshow)
          create(:reservation, status: :cancelled)
          req(statuses: "active, noshow")
        end

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 2 }
        end

        context "response[:items]" do
          subject { parsed_response_body[:items] }

          it { is_expected.to all(include(status: "active").or(include(status: "noshow"))) }
          it { expect(subject.count).to eq 2 }
        end
      end

      context "search by secret" do
        subject { response }

        before do
          create(:reservation, status: :active)
          create(:reservation, status: :active)
          create(:reservation, status: :active)
          req(secret:)
        end

        let(:secret) { Reservation.all.sample.secret }

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(items: Array, metadata: Hash) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
        end

        context "response[:items]" do
          subject { parsed_response_body[:items] }

          it { is_expected.to all(include(secret:)) }
        end

        context "response[:items][0]" do
          subject { parsed_response_body[:items][0] }

          it_behaves_like RESERVATION_TEST_STRUCTURE, phone: true, email: true, notes: true
        end
      end

      context "search by query" do
        subject { response }

        let!(:reservations) do
          [
            create(:reservation, status: :active, fullname: "Wassa Bratan", email: "giuly@presley",
                   notes: "Please be kind"),
            create(:reservation, status: :active, fullname: "Gigi", email: "luis@sal", notes: "Dont worry"),
            create(:reservation, status: :active, fullname: "Orologio", email: "gianni@morandi",
                   notes: "idk something else")
          ]
        end

        let(:query) { nil }

        before { req(query:) }

        context "should filter by fullname" do
          let(:query) { reservations.sample.fullname.split(" ").sample }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:fullname]).to include(query) }
        end

        context "should filter by email" do
          let(:query) { reservations.sample.email.split("@").first }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:email]).to include(query) }
        end

        context "should filter by notes" do
          let(:query) { reservations.sample.notes.split(" ").sample }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:notes]).to include(query) }
        end
      end

      context "search by date" do
        let!(:reservations) do
          [
            create(:reservation, status: :active, datetime: 1.day.from_now),
            create(:reservation, status: :active, datetime: Time.now),
            create(:reservation, status: :active, datetime: 1.day.ago),
            create(:reservation, status: :active, datetime: 2.days.ago),
            create(:reservation, status: :active, datetime: 3.days.ago)
          ]
        end

        context "when filtering by today with {today: true}" do
          subject { response }

          before { req(today: true) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
        end

        context "when filtering by today with {date: Date.today.to_date}" do
          subject { response }

          before { req(date: Date.today.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }
          it { expect(parsed_response_body[:items][0][:datetime].to_date).to eq Time.now.to_date }
        end

        context "when filtering by {date_from: 1.day.from_now.to_date}" do
          subject { response }

          before { req(date_from: 1.day.from_now.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }

          it {
            expect(parsed_response_body[:items].map do |item|
              item[:datetime].to_date
            end).to all(eq(1.day.from_now.to_date.to_date))
          }
        end

        context "when filtering by {date_from: 1.day.from_now.to_date, date_to: 1.day.from_now.to_date}" do
          subject { response }

          before { req(date_from: 1.day.from_now.to_date, date_to: 1.day.from_now.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }

          it {
            expect(parsed_response_body[:items].map do |item|
              item[:datetime].to_date
            end).to all(eq(1.day.from_now.to_date.to_date))
          }
        end

        # SHOULD ACTUALLY IGNORE TIME WHEN PROVIDING 'date_from'
        context "when filtering by {date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date}" do
          subject { response }

          before { req(date_from: 1.day.from_now.end_of_day.to_datetime.to_s, date_to: 1.day.from_now.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 1 }

          it {
            expect(parsed_response_body[:items].map do |item|
              item[:datetime].to_date
            end).to all(eq(1.day.from_now.to_date.to_date))
          }
        end

        # SHOULD NOT IGNORE TIME WHEN PARAM IS CALLED 'datetime_from'
        context "when filtering by {datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date}" do
          subject { response }

          before { req(datetime_from: 1.day.from_now.end_of_day.to_datetime.to_s, datetime_to: 1.day.from_now.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body[:items].count).to eq 0 }
        end
      end

      context "when ordering with {order_by: 'id'}" do
        before do
          create_list(:reservation, 2)
          req(order_by: "id")
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 2 }
        it { expect(parsed_response_body.dig(:items, 0, :id)).to be < parsed_response_body.dig(:items, 1, :id) }
      end

      context "when ordering with {order_by: { field: 'id' }}" do
        before do
          create_list(:reservation, 2)
          req(order_by: { field: "id" })
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 2 }
        it { expect(parsed_response_body.dig(:items, 0, :id)).to be < parsed_response_body.dig(:items, 1, :id) }
      end

      context "when ordering with {order_by: { attribute: 'id', direction: 'DESC' }}" do
        before do
          create_list(:reservation, 2)
          req(order_by: { attribute: "id", direction: "DESC" })
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 2 }
        it { expect(parsed_response_body.dig(:items, 0, :id)).to be > parsed_response_body.dig(:items, 1, :id) }
      end

      context 'when ordering with {order_by: { attribute: "datetime" }}' do
        before do
          create(:reservation, datetime: "2024-10-12 19:00")
          create(:reservation, datetime: "2024-10-12 20:00")
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: { attribute: "datetime" })
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 3 }
        it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
        it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
        it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
      end

      context 'when ordering with {order_by: { attribute: "some_invalid_col" }}' do
        before do
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: { attribute: "some_invalid_col" })
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 1 }
        it { expect(response).to have_http_status(:ok) }
      end

      context 'when ordering with {order_by: "some_invalid_col" }' do
        before do
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: "some_invalid_col")
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 1 }
        it { expect(response).to have_http_status(:ok) }
      end

      context 'when ordering with {order_by: { attribute: "datetime", order: "DESC" }}' do
        before do
          create(:reservation, datetime: "2024-10-12 19:00")
          create(:reservation, datetime: "2024-10-12 20:00")
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: { attribute: "datetime", order: "DESC" })
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 3 }
        it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
        it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
        it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
      end

      context 'when ordering with {order_by_attribute: "datetime", order_by_order: "DESC"}' do
        before do
          create(:reservation, datetime: "2024-10-12 19:00")
          create(:reservation, datetime: "2024-10-12 20:00")
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by_attribute: "datetime", order_by_order: "DESC")
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 3 }
        it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
        it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
        it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
      end

      %w[dir order sort direction].each do |direction_alias|
        %w[attribute column field by].each do |attribute_alias|
          context "when ordering with {order_by: { #{attribute_alias.inspect}: 'datetime', #{direction_alias.inspect}: 'DESC' }}" do
            before do
              create(:reservation, datetime: "2024-10-12 19:00")
              create(:reservation, datetime: "2024-10-12 20:00")
              create(:reservation, datetime: "2024-10-12 14:00")
              req(order_by: { attribute_alias => "datetime", direction_alias => "DESC" })
            end

            it "allows any combination between aliases." do
              expect(parsed_response_body).to include(items: Array, metadata: Hash)
              expect(parsed_response_body[:items].length).to eq 3
              expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 20:00")
              expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00")
              expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 14:00")
            end
          end
        end
      end

      context 'when ordering with {order_by: "datetime DESC"}' do
        before do
          create(:reservation, datetime: "2024-10-12 19:00")
          create(:reservation, datetime: "2024-10-12 20:00")
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: "datetime DESC")
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 3 }
        it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
        it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
        it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
      end

      context 'when ordering with {order_by: "datetime ASC"}' do
        before do
          create(:reservation, datetime: "2024-10-12 19:00")
          create(:reservation, datetime: "2024-10-12 20:00")
          create(:reservation, datetime: "2024-10-12 14:00")
          req(order_by: "datetime ASC")
        end

        it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
        it { expect(parsed_response_body[:items].length).to eq 3 }
        it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
        it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
        it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
      end
    end
  end

  describe "GET #show" do
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:show) }
    it { expect(described_class).to route(:get, "/v1/admin/reservations/2").to(action: :show, format: :json, id: 2) }

    def req(id, params = {})
      get :show, params: params.merge(id:)
    end

    context "when user is not authenticated" do
      before { req(2) }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "basic" do
        subject { response }

        before { req(reservation.id) }

        it { is_expected.to have_http_status(:ok) }

        context "response" do
          subject { parsed_response_body[:item].transform_keys(&:to_sym) }

          it { is_expected.to be_a(Hash) }
          it { is_expected.to include(:id, :updated_at) }

          it_behaves_like RESERVATION_TEST_STRUCTURE
        end
      end

      context "when passing a invalid id" do
        subject { response }

        before { req(id: 999_999) }

        it_behaves_like NOT_FOUND
      end

      context "checking pixel events" do
        before do
          CreateMissingImages.run!
          reservation.deliver_confirmation_email
          reservation.image_pixels.first.events.create!(event_time: Time.now)
          req(reservation.id)
        end

        it do
          expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels)).to be_a(Array)
          expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).length).to eq 1
          json = parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).first
          expect(json).to be_a(Hash)
          expect(json).to include(events: Array)
          expect(json[:events]).to all(be_a(Hash))
          expect(json[:events]).to all(include(id: Integer, event_time: String))
          expect(json[:events].length).to eq 1
        end
      end
    end
  end

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

  describe "PATCH #update" do
    let(:params) { {} }
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/reservations/2").to(action: :update, id: "2", format: :json)
    }

    def req(id = reservation.id, data = params)
      patch :update, params: data.merge(id:)
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it do
        reservation
        expect { req(reservation.id) }.not_to change(Reservation, :count)
      end

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when updating adults" do
        let(:params) { { adults: 10 } }

        it do
          expect { req }.to change { reservation.reload.adults }.from(reservation.adults).to(10)
        end
      end

      context "when updating fullname" do
        let(:fullname) { "Anne Marie" + SecureRandom.hex }
        let(:params) { { fullname: } }

        it do
          expect { req }.to change { reservation.reload.fullname }.from(reservation.fullname).to(fullname)
        end
      end

      context "when updating datetime" do
        let(:datetime) { reservation.datetime + 1.day }
        let(:params) { { datetime: } }

        it do
          expect { req }.to change { reservation.reload.datetime }.from(reservation.datetime).to(datetime)
        end
      end

      context "when updating table" do
        let(:table) { "204" }
        let(:params) { { table: } }

        it do
          expect { req }.to change { reservation.reload.table }.from(reservation.table).to(table)
        end
      end

      context "when updating notes" do
        let(:notes) { "Please be kind" + SecureRandom.hex }
        let(:params) { { notes: } }

        it do
          expect { req }.to change { reservation.reload.notes }.from(reservation.notes).to(notes)
        end
      end

      context "when updating email" do
        let(:email) { "giuly@presley" + SecureRandom.hex }
        let(:params) { { email: } }

        it do
          expect { req }.to change { reservation.reload.email }.from(reservation.email).to(email)
        end
      end

      context "when updating phone" do
        let(:phone) { "123 333 333" }
        let(:params) { { phone: } }

        it do
          expect { req }.to change { reservation.reload.phone }.from(reservation.phone).to(phone)
        end
      end

      context "when updating status: does nothing" do
        let(:params) { { status: :cancelled } }

        it do
          reservation.active!

          expect { req }.not_to change { reservation.reload.status }.from(reservation.status)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:destroy) }

    it {
      expect(described_class).to route(:delete, "/v1/admin/reservations/2").to(action: :destroy, id: "2", format: :json)
    }

    def req(id = reservation.id)
      delete :destroy, params: { id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "(authenticated)" do
      before { authenticate_request }

      it do
        reservation
        expect { req(reservation.id) }.not_to change(Reservation, :count)
      end

      it do
        reservation
        expect { req(reservation.id) }.to change { Reservation.visible.count }.by(-1)
      end

      it do
        expect { req(reservation.id) }.to change { reservation.reload.status }.from(reservation.status).to("deleted")
      end

      context "when trying to delete a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end
    end
  end

  describe "PATCH #update_status" do
    let(:status) { "arrived" }
    let(:reservation) { create(:reservation) }

    it { expect(instance).to respond_to(:update) }

    it {
      expect(described_class).to route(:patch, "/v1/admin/reservations/2/status/arrived").to(status: "arrived",
                                                                                             action: :update_status, id: "2", format: :json)
    }

    def req(id = reservation.id, status2set = status)
      patch :update_status, params: { id:, status: status2set }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when updating status to arrived" do
        let(:status) { "arrived" }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when updating status to noshow" do
        let(:status) { "noshow" }

        it do
          expect { req }.to change { reservation.reload.status }.from(reservation.status).to(status)
          expect(parsed_response_body).to include(item: Hash)
          expect(parsed_response_body[:item]).to include(id: Integer, status:, created_at: String)
          expect(response).to have_http_status(:ok)
        end
      end

      context "when updating status to cancelled" do
        let(:status) { "cancelled" }

        it do
          expect { req }.not_to(change { reservation.reload.status })
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response_body[:message].to_s.downcase).to include("status")
        end
      end

      context "when updating status to deleted" do
        let(:status) { "deleted" }

        it do
          expect { req }.not_to(change { reservation.reload.status })
          expect(parsed_response_body).to include(message: String, details: Hash)
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response_body[:message].to_s.downcase).to include("status")
        end
      end
    end
  end

  context "POST #add_tag" do
    let(:tag) { create(:reservation_tag) }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/2/add_tag/3").to(tag_id: "3", action: :add_tag,
                                                                                       id: "2", format: :json)
    }

    it { expect(instance).to respond_to(:add_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      post :add_tag, params: { id: reservation_id, tag_id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999, tag.id) }

        it_behaves_like NOT_FOUND
      end

      context "when trying to add a non-existing tag" do
        subject { response }

        before { req(reservation.id, 999_999_99) }

        it_behaves_like NOT_FOUND
      end

      context "when reservation and tag are valid" do
        before do
          reservation
          tag
        end

        it { expect { req }.to change { TagInReservation.count }.by(1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(0).to(1) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 1
        end

        it "can try to add twice the tag, will be added just once." do
          expect { req }.to change { TagInReservation.count }.by(1)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { TagInReservation.count })
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "when cannot add tag for some reason" do
        let(:error_msg) { "OOps some invalid value here" }

        before do
          reservation
          tag
          allow_any_instance_of(TagInReservation).to receive(:valid?).and_return(false)
          errors = ActiveModel::Errors.new(TagInReservation.new)
          errors.add(:base, error_msg)
          allow_any_instance_of(TagInReservation).to receive(:errors).and_return(errors)
        end

        it { expect { req }.not_to(change { TagInReservation.count }) }

        it "returns 422 with message" do
          req
          expect(parsed_response_body).to include(message: String)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(parsed_response_body[:message]).to include(error_msg)
        end
      end
    end
  end

  context "DELETE #remove_tag" do
    let(:tag) { create(:reservation_tag) }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:delete, "/v1/admin/reservations/2/remove_tag/3").to(tag_id: "3",
                                                                                            action: :remove_tag, id: "2", format: :json)
    }

    it { expect(instance).to respond_to(:remove_tag) }

    def req(reservation_id = reservation.id, tag_id = tag.id)
      delete :remove_tag, params: { id: reservation_id, tag_id: }
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to update a non-existing reservation" do
        subject { response }

        before { req(999_999, tag.id) }

        it_behaves_like NOT_FOUND
      end

      context "when trying to add a non-existing tag" do
        subject { response }

        before { req(reservation.id, 999_999_99) }

        it_behaves_like NOT_FOUND
      end

      context "when reservation and tag are valid" do
        before do
          reservation.tags = [tag]
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(1).to(0) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }
        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 0
        end

        it "when removing same tag twice, should be fine." do
          expect { req }.to change { reservation.reload.tags.count }.from(1).to(0)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { reservation.reload.tags.count })
          expect(response).to have_http_status(:ok)
        end
      end

      context "when reservation has 3 tags" do
        let(:tags) { create_list(:reservation_tag, 3) }
        let(:tag) { tags.sample }

        before do
          reservation.tags = tags
        end

        it { expect { req }.to change { TagInReservation.count }.by(-1) }
        it { expect { req }.not_to(change { Reservation.count }) }
        it { expect { req }.not_to(change { ReservationTag.count }) }
        it { expect { req }.to change { reservation.reload.tags.count }.from(3).to(2) }
        it { expect { req }.not_to(change { tag.reload.as_json }) }
        it { expect { req }.not_to(change { reservation.reload.as_json }) }

        it "is successful" do
          req
          expect(parsed_response_body).to include(item: Hash)
          expect(response).to have_http_status(:ok)
          expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
          expect(parsed_response_body[:item]).to include(tags: Array)
          expect(parsed_response_body.dig(:item, :tags).count).to eq 2
        end

        it "when removing same tag twice, should be fine." do
          expect { req }.to change { reservation.reload.tags.count }.from(3).to(2)
          expect(response).to have_http_status(:ok)
          expect { req }.not_to(change { reservation.reload.tags.count })
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end

  context "POST #deliver_confirmation_email" do
    let(:params) { { id: reservation.id } }
    let(:reservation) { create(:reservation) }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/2/deliver_confirmation_email").to(
        action: :deliver_confirmation_email, id: "2", format: :json
      )
    }

    it {
      expect(described_class).to route(:post, "/v1/admin/reservations/55/deliver_confirmation_email").to(
        action: :deliver_confirmation_email, id: "55", format: :json
      )
    }

    it { expect(instance).to respond_to(:deliver_confirmation_email) }

    def req(_params = params)
      post :deliver_confirmation_email, params: _params
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request }

      context "when trying to deliver a non-existing reservation" do
        subject { response }

        before { req(id: 999_999) }

        it_behaves_like NOT_FOUND
      end

      context "when reservation is valid" do
        before { allow_any_instance_of(Hash).to receive(:dig!).and_return("something") }

        it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }

        it "is successful" do
          req
          expect(parsed_response_body).not_to include(message: String)
          expect(response).to have_http_status(:ok)
        end

        context "when reservation has name" do
          before do
            allow_any_instance_of(Hash).to receive(:dig!).and_call_original
            CreateMissingImages.run!
          end

          let(:reservation) { create(:reservation, fullname: "Anne Marie") }
          let(:to) { ActionMailer::Base.deliveries.last.header[:to].unparsed_value }

          it { expect { req }.to change { ActionMailer::Base.deliveries.count }.by(1) }
          it { expect { req }.to change { Log::DeliveredEmail.count }.by(1) }
          it { expect { req }.to change { Log::DeliveredEmail.where(record: reservation).count }.by(1) }
          it { expect { req }.to change { Log::ImagePixel.count }.by(1) }

          it "is successful" do
            req
            expect(to).to include(reservation.email)
            expect(to).to include(reservation.fullname)
            expect(parsed_response_body).not_to include(message: String)
            expect(response).to have_http_status(:ok)
          end

          it "last delivered email should have the correct reservation" do
            Log::DeliveredEmail.delete_all
            Log::ImagePixel.delete_all
            req
            expect(Log::DeliveredEmail.last.subject).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.text).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.html).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.raw).to include(reservation.fullname)
            expect(Log::DeliveredEmail.last.html).to include(Log::ImagePixel.last.url)
            expect(Log::DeliveredEmail.last.record).to eq reservation
          end
        end

        context "when reservation has no email" do
          let(:reservation) { create(:reservation, email: nil) }
          let(:to) { ActionMailer::Base.deliveries.last.header[:to].unparsed_value }

          it { expect { req }.not_to(change { ActionMailer::Base.deliveries.count }) }

          it "is successful" do
            req
            expect(parsed_response_body).to include(message: String, details: Hash)
            expect(response).to have_http_status(:bad_request)
          end
        end

        context "after request" do
          before { req }

          it "returns delivery details" do
            expect(parsed_response_body).to include(item: Hash)
            expect(parsed_response_body[:item]).to include(id: Integer, created_at: String)
            expect(response).to have_http_status(:ok)
          end

          it do
            expect(parsed_response_body.dig(:item, :delivered_emails)).to be_a(Array)
            expect(parsed_response_body.dig(:item, :delivered_emails).length).to eq 1
            expect(parsed_response_body.dig(:item,
                                            :delivered_emails).first).to include(id: Integer, created_at: String,
                                                                                 image_pixels: Array)
            expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels)).to be_a(Array)
            expect(parsed_response_body.dig(:item, :delivered_emails, 0, :image_pixels).length).to eq 0
          end
        end
      end
    end
  end

  describe "GET #tables_summary" do
    it { expect(instance).to respond_to(:tables_summary) }
    it { expect(described_class).to route(:get, "/v1/admin/reservations/tables_summary").to(action: :tables_summary, format: :json) }

    def req(params = { date: Time.zone.now.to_date.to_s })
      get :tables_summary, params:
    end

    context "when user is not authenticated" do
      before { req }

      it_behaves_like UNAUTHORIZED
    end

    context "when user is authenticated" do
      before { authenticate_request(user:) }

      context "when param :date is missing" do
        subject { response }

        before do
          create(:reservation)
          req({ date: nil })
        end

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(parsed_response_body).to include(message: /date/) }
      end

      context "when param :date is invalid" do
        subject { response }

        before do
          create(:reservation)
          req(date: "today")
        end

        it { is_expected.to have_http_status(:bad_request) }
        it { expect(parsed_response_body).to include(message: /date/) }
      end

      context "when searching by date" do
        let!(:reservations) do
          [
            create(:reservation, status: :active, datetime: 1.day.from_now, adults: 1),
            create(:reservation, status: :active, datetime: Time.now, adults: 2),
            create(:reservation, status: :active, datetime: 1.day.ago, adults: 3),
            create(:reservation, status: :active, datetime: 2.days.ago, adults: 4),
            create(:reservation, status: :active, datetime: 3.days.ago, adults: 5)
          ]
        end

        let!(:reservation_turns) do
          (0..6).each do |weekday|
            ReservationTurn.create!(name: "Day", weekday:, starts_at: "00:01", ends_at: "23:59")
          end
        end

        context "when filtering both time and date, should return only the only necessary turn" do
          let!(:reservation_turns) do
            (0..6).each do |weekday|
              ReservationTurn.create!(name: "Pranzo", weekday:, starts_at: "08:00", ends_at: "14:00")
              ReservationTurn.create!(name: "Cena", weekday:, starts_at: "19:00", ends_at: "21:00")
            end
          end

          let!(:reservations) do
            [
              # LUNCH
              create(:reservation, status: :active, datetime: Time.zone.now.beginning_of_day + 9.hours, adults: 1),
              create(:reservation, status: :active, datetime: Time.zone.now.beginning_of_day + 13.hours, adults: 2),

              # DINNER
              create(:reservation, status: :active, datetime: Time.zone.now.beginning_of_day + 20.hours, adults: 3),
              create(:reservation, status: :active, datetime: Time.zone.now.beginning_of_day + 20.hours, adults: 4),
              create(:reservation, status: :active, datetime: Time.zone.now.beginning_of_day + 20.hours, adults: 4),
            ]
          end

          context "when filtering by today for lunch time" do
            subject { response }

            before { req(date: Time.zone.now.to_date.to_s, time: "10:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
            it { expect(parsed_response_body.count).to eq 1 }
            it { expect(parsed_response_body[0]["summary"]).to eq("1" => 1, "2" => 1) }
          end

          context "when filtering by today for dinner time" do
            subject { response }

            before { req(date: Time.zone.now.to_date.to_s, time: "21:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
            it { expect(parsed_response_body.count).to eq 1 }
            it { expect(parsed_response_body[0]["summary"]).to eq("3" => 1, "4" => 2) }
          end

          context "when filtering for today but when there are no turns" do
            subject { response }

            before { req(date: Time.zone.now.to_date.to_s, time: "1:00") }

            it { is_expected.to have_http_status(:ok) }
            it { expect(parsed_response_body).not_to include(message: String) }
            it { expect(parsed_response_body.count).to eq 0 }
          end

        end

        context "when filtering by today with {date: Date.today.to_date}" do
          subject { response }

          before { req(date: Date.today.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body).to all(include("summary" => Hash, "turn" => Hash)) }
          it { expect(parsed_response_body[0]["summary"]).to eq("2" => 1) }
        end

        context "when filtering by today with {date: Date.yesterday.to_date}" do
          subject { response }

          before { req(date: Date.yesterday.to_date) }

          it { is_expected.to have_http_status(:ok) }
          it { expect(parsed_response_body).not_to include(message: String) }
          it { expect(parsed_response_body[0]["summary"]).to eq("3" => 1) }
        end
      end
    end
  end
end
