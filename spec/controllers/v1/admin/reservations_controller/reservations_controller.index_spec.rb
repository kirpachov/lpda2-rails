# frozen_string_literal: true

require "rails_helper"

RSpec.shared_context "V1::Admin::ReservationsController#index item structure" do |options = {}|
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

RSpec.shared_context "V1::Admin::ReservationsController#index successful response" do
  it { expect(json).to include(items: Array, metadata: Hash) }
  it { expect(response).to have_http_status(:ok) }

  context "response[:items][0]" do
    subject { parsed_response_body[:items][0] }

    it_behaves_like "V1::Admin::ReservationsController#index item structure"
  end
end

RSpec.describe V1::Admin::ReservationsController, type: :controller do
  include_context CONTROLLER_UTILS_CONTEXT
  include_context CONTROLLER_AUTHENTICATION_CONTEXT
  include_context TESTS_OPTIMIZATIONS_CONTEXT
  # include_context SIDEKIQ_INLINE_TESTING

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

          it_behaves_like "V1::Admin::ReservationsController#index item structure", phone: true, email: true, notes: true
        end
      end

      context "when filtering by payment_status" do
        let!(:reservation_todo) do
          create(:reservation, payment: p).tap do |r|
            create(:reservation_payment, :with_hpp_url, status: :todo, reservation: r)
          end
        end

        let!(:reservation_paid) do
          create(:reservation, payment: p).tap do |r|
            create(:reservation_payment, :with_hpp_url, status: :paid, reservation: r)
          end
        end

        let!(:reservation_authorized) do
          create(:reservation, payment: p).tap do |r|
            create(:reservation_payment, :with_hpp_url, status: :authorized, reservation: r)
          end
        end

        let!(:reservation_refunded) do
          create(:reservation, payment: p).tap do |r|
            create(:reservation_payment, :with_hpp_url, status: :refunded, reservation: r)
          end
        end

        let!(:reservation_without_payment) do
          create(:reservation, payment: nil)
        end

        context "when filtering by payment_status: 'todo', will return reservations that have todo payment status" do
          before { req(payment_status: "todo") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_todo.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:payment).map { |j| j[:status] }).to all(eq("todo")) }
        end


        context "when filtering by payment_status: 'todo,paid', will return reservations that have todo payment status" do
          before { req(payment_status: "todo,paid") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_todo.id, reservation_paid.id]) }
          it { expect(json[:metadata][:total_count]).to eq(2) }
        end

        context "when filtering by payment_status: 'paid', will return reservations that have paid payment status" do
          before { req(payment_status: "paid") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_paid.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:payment).map { |j| j[:status] }).to all(eq("paid")) }
        end

        context "when filtering by payment_status: 'authorized', will return reservations that have authorized payment status" do
          before { req(payment_status: "authorized") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_authorized.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:payment).map { |j| j[:status] }).to all(eq("authorized")) }
        end

        context "when filtering by payment_status: 'refunded', will return reservations that have refunded payment status" do
          before { req(payment_status: "refunded") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_refunded.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:payment).map { |j| j[:status] }).to all(eq("refunded")) }
        end

        context "when filtering by payment_status: <nil>: will return all reservations, no filters applied" do
          before { req(payment_status: [nil, "", " "].sample) }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_todo.id, reservation_paid.id, reservation_authorized.id, reservation_refunded.id, reservation_without_payment.id]) }
          it { expect(json[:metadata][:total_count]).to eq(5) }
          # it { expect(json[:items].pluck(:payment).map { |j| j[:status] }).to all(be_present) }
        end
      end

      context "when filtering by table_type" do
        let(:table_types) { create_list(:table_type, 2) }

        let!(:reservation_with_table_type) { create(:reservation, table_type: table_types.first) }
        let!(:reservation_with_table_type_2) { create(:reservation, table_type: table_types.last) }
        let!(:res_without_table_type) { create(:reservation, table_type: nil) }

        context "when filtering by table_type: 'some', will return reservations that have some table type associated" do
          before { req(table_type: "some") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_with_table_type.id, reservation_with_table_type_2.id]) }
          it { expect(json[:metadata][:total_count]).to eq(2) }
          it { expect(json[:items].pluck(:table_type)).to all(be_present) }
        end

        context "when filtering by table_type: 'none', will return reservations without any table type" do
          before { req(table_type: "none") }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([res_without_table_type.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:table_type)).to all(be_blank) }
        end

        context "when filtering by table_type: '<id-of-table-type>', will return reservations with that table type" do
          before { req(table_type: [table_types.first.id, table_types.first.id.to_s]) }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_with_table_type.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:table_type)).to all(be_present) }
        end

        context "when filtering by table_type: '<id-of-table-type>,<id-of-second-table-type>', will return reservations with one of the provided table types associated" do
          before { req(table_type: table_types.map(&:id).map(&:to_s).join(',')) }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_with_table_type.id, reservation_with_table_type_2.id]) }
          it { expect(json[:metadata][:total_count]).to eq(2) }
          it { expect(json[:items].pluck(:table_type)).to all(be_present) }
        end

        context "when filtering by table_type: '<id-of-table-type>,<id-some-other-number>', will return reservations with one of the provided table types associated" do
          before { req(table_type: [table_types.first.id, 99].join(",")) }

          it_behaves_like "V1::Admin::ReservationsController#index successful response"

          it { expect(json[:items].pluck(:id)).to match_array([reservation_with_table_type.id]) }
          it { expect(json[:metadata][:total_count]).to eq(1) }
          it { expect(json[:items].pluck(:table_type)).to all(be_present) }
        end
      end

      context "when reservation has table type" do
        before do
          create(:reservation, table_type: create(:table_type, :with_images))
          create(:reservation, table_type: create(:table_type, :with_images))
          req
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(json).not_to include(message: String) }

        it { expect(json[:items].first).to include(table_type: Hash) }

        it {
          expect(json[:items].first[:table_type]).to include(name: String, description: String, id: Integer,
                                                             default_people_per_turn: Integer, default_price: Float, images: Array)
        }
      end

      %w[todo paid].each do |payment_status|
        context "when reservations have payment but with status #{payment_status.inspect}" do
          before do
            create(:reservation)
            create(:reservation_payment, reservation: create(:reservation), status: payment_status)

            req
          end

          it { expect(Reservation.count).to eq 2 }
          it { expect(ReservationPayment.count).to eq 1 }

          it { expect(response).to have_http_status(:ok) }
          it { expect(json[:items].count).to eq 2 }
          it { expect(json[:items].filter { |j| j.keys.include?("payment") }.filter(&:present?).count).to eq(1) }
          it { expect(json[:items].filter { |j| j.keys.include?("payment") }.first).to be_present }

          it do
            expect(json[:items].pluck(:payment).filter(&:present?)).to all(include(:external_id))
          end

          it {
            expect(json[:items].filter do |j|
                     j.keys.include?("payment")
                   end.first["payment"].symbolize_keys).to include(hpp_url: String, status: payment_status)
          }
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

          it_behaves_like "V1::Admin::ReservationsController#index item structure", phone: true, email: true, notes: true
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

      %w[order_by_attribute order_by_field].each do |order_by_field_name|
        %w[order_by_direction order_by_order].each do |order_by_order_name|
          context "when ordering with {#{order_by_field_name}: 'datetime', #{order_by_order_name}: 'DESC'}" do
            before do
              create(:reservation, datetime: "2024-10-12 19:00")
              create(:reservation, datetime: "2024-10-12 20:00")
              create(:reservation, datetime: "2024-10-12 14:00")
              req(order_by_field_name => "datetime", order_by_order_name.to_sym => "DESC")
            end

            it { expect(parsed_response_body).to include(items: Array, metadata: Hash) }
            it { expect(parsed_response_body[:items].length).to eq 3 }
            it { expect(parsed_response_body.dig(:items, 0, :datetime)).to eq to_iso8601("2024-10-12 20:00") }
            it { expect(parsed_response_body.dig(:items, 1, :datetime)).to eq to_iso8601("2024-10-12 19:00") }
            it { expect(parsed_response_body.dig(:items, 2, :datetime)).to eq to_iso8601("2024-10-12 14:00") }
          end
        end
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
end
