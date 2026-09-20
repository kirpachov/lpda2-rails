# frozen_string_literal: true

require "rails_helper"

# The examples below exercise the raw Rack app built by RoutesBasicAuth via
# Rack::MockRequest, so responses are Rack::MockResponse instances rather than
# Rails response objects and are not compatible with the have_http_status matcher.
# rubocop:disable RSpec/Rails/HaveHttpStatus
RSpec.describe RoutesBasicAuth do
  describe ".call" do
    let(:dummy_app) do
      Class.new do
        def self.call(_env)
          [200, { "Content-Type" => "text/plain" }, ["Hello!"]]
        end
      end
    end

    def basic_auth_header(username, password)
      { "HTTP_AUTHORIZATION" => "Basic #{Base64.strict_encode64("#{username}:#{password}")}" }
    end

    context "when klass is not a Class" do
      it "raises ArgumentError" do
        expect do
          described_class.call("not_a_class", username: "user", password: "pass")
        end.to raise_error(ArgumentError, "klass must be a class")
      end
    end

    context "when username and password are both present" do
      let(:app) { described_class.call(dummy_app, username: "user", password: "pass") }

      context "when correct credentials are provided" do
        subject(:response) { Rack::MockRequest.new(app).get("/", basic_auth_header("user", "pass")) }

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to eq("Hello!") }
      end

      context "when incorrect credentials are provided" do
        subject(:response) { Rack::MockRequest.new(app).get("/", basic_auth_header("user", "wrong")) }

        it { expect(response.status).to eq(401) }
      end

      context "when no credentials are provided" do
        subject(:response) { Rack::MockRequest.new(app).get("/") }

        it { expect(response.status).to eq(401) }
      end
    end

    context "when username is blank" do
      let(:app) { described_class.call(dummy_app, username: "", password: "pass") }

      context "when a request is made" do
        subject(:response) { Rack::MockRequest.new(app).get("/") }

        it { expect(response.status).to eq(200) }
        it { expect(response.body).to eq("Hello!") }
      end

      it "logs a warning" do
        allow(Rails.logger).to receive(:warn)
        Rack::MockRequest.new(app).get("/")
        expect(Rails.logger).to have_received(:warn).with(/No username or password provided/)
      end
    end

    context "when password is blank" do
      subject(:response) { Rack::MockRequest.new(app).get("/") }

      let(:app) { described_class.call(dummy_app, username: "user", password: nil) }

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to eq("Hello!") }
    end

    context "when both username and password are blank" do
      subject(:response) { Rack::MockRequest.new(app).get("/") }

      let(:app) { described_class.call(dummy_app, username: nil, password: nil) }

      it { expect(response.status).to eq(200) }
      it { expect(response.body).to eq("Hello!") }
    end
  end
end
# rubocop:enable RSpec/Rails/HaveHttpStatus
