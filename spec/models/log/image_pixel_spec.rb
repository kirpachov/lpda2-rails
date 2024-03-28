# frozen_string_literal: true

require "rails_helper"

RSpec.describe Log::ImagePixel, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:event_type) }
    it { is_expected.to validate_inclusion_of(:event_type).in_array(%w[email_open]) }
    it { is_expected.not_to allow_value("invalid").for(:event_type) }

    %w[email_open].each do |event_type|
      it { is_expected.to allow_value(event_type).for(:event_type) }
    end
    it { is_expected.not_to allow_value("").for(:event_type) }
    it { is_expected.not_to allow_value(nil).for(:event_type) }

    it { is_expected.not_to allow_value(nil).for(:secret) }
    it { is_expected.not_to allow_value("").for(:secret) }
    it { is_expected.to validate_presence_of(:secret) }
  end

  context "associations" do
    let!(:pixel) { create(:log_image_pixel, :with_record, :with_image, :with_delivered_email) }

    it { is_expected.to belong_to(:image).class_name("Image").optional(false) }
    it { is_expected.to belong_to(:record).optional(false) }

    context "adding record" do
      it { expect { pixel.record = create(:user) }.to change { pixel.record_id }.from(pixel.record_id) }
    end

    context "adding image" do
      it { expect { pixel.image = create(:image) }.to change { pixel.image_id }.from(pixel.image_id) }
    end

    context "has many events" do
      let!(:event) { create(:log_image_pixel_event, image_pixel: pixel) }

      before do
        pixel.reload
      end

      it { expect(pixel.events).to include(event) }

      it do
        expect { pixel.events.create!(attributes_for(:log_image_pixel_event)) }.to change {
                                                                                     pixel.reload.events.count
                                                                                   }.from(1).to(2)
      end
    end
  end

  context "instance methods" do
    let!(:pixel) { build(:log_image_pixel) }

    it "sets event_type" do
      expect(pixel.event_type).to be_present
    end

    it "sets secret" do
      expect(pixel.secret).to be_present
    end

    describe "#url" do
      it { expect(pixel).to respond_to(:url) }

      it "returns the url" do
        expect(pixel.url).to match(/^http/)
      end
    end
  end
end
