# frozen_string_literal: true

require "rails_helper"

RSpec.describe Log::DeliveredEmail, type: :model do
  it "can be created empty" do
    expect { described_class.create! }.not_to raise_error
  end

  it "can be created with record" do
    expect { described_class.create!(record: create(:user)) }.not_to raise_error
  end

  it "can be created with text" do
    expect { described_class.create!(text: "text") }.not_to raise_error
  end

  it "can be created with html" do
    expect { described_class.create!(html: "html") }.not_to raise_error
  end

  it "can be created with subject" do
    expect { described_class.create!(subject: "subject") }.not_to raise_error
  end

  it "can be created with headers" do
    expect { described_class.create!(headers: { from: "me" }) }.not_to raise_error
  end

  it "can be created with raw" do
    expect { described_class.create!(raw: "raw") }.not_to raise_error
  end
end
