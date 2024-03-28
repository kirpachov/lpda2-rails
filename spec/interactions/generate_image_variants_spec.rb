# frozen_string_literal: true

require "rails_helper"

RSpec.describe GenerateImageVariants, type: :interaction do
  let(:number_of_variants) { 1 }

  include_context TESTS_OPTIMIZATIONS_CONTEXT

  context "inputs" do
    it { is_expected.to have_input(:image).of_type(Image).mandatory }

    context "non-original image should not be valid" do
      subject { described_class.run(image:) }

      let(:image) { create(:image, :with_attached_image, :with_original) }

      it { expect(image).to be_valid }
      it { expect(image).to be_persisted }
      it { is_expected.not_to be_valid }
      it { expect(image.children).to be_empty }

      context "errors" do
        subject { described_class.run(image:).errors }

        it { is_expected.to be_a(ActiveModel::Errors) }
        it { is_expected.not_to be_empty }
        it { is_expected.to include(:image) }
        it { expect(subject[:image]).to include("must be original") }
      end

      context "after run" do
        subject { described_class.run(image:) }

        it { expect(image.children).to be_empty }

        it "image should not have a child image" do
          expect { subject }.not_to(change { image.children.count })
        end
      end
    end

    context "original image should be valid" do
      subject { described_class.run(image:) }

      let(:image) { create(:image, :with_attached_image) }

      it { expect(image).to be_valid }
      it { expect(image).to be_persisted }
      it { is_expected.to be_valid }

      context "errors" do
        subject { described_class.run(image:).errors }

        it { is_expected.to be_a(ActiveModel::Errors) }
        it { is_expected.to be_empty }
      end

      context "after run" do
        subject { described_class.run(image:) }

        it "image should have a child image" do
          expect { subject }.to change { image.children.count }.by(number_of_variants)
        end
      end
    end

    context "not persisted image should not be valid" do
      subject { described_class.run(image:) }

      let(:image) { build(:image) }

      it { expect(image).to be_valid }
      it { expect(image).not_to be_persisted }
      it { is_expected.not_to be_valid }

      context "errors" do
        subject { described_class.run(image:).errors }

        it { is_expected.to be_a(ActiveModel::Errors) }
        it { is_expected.to include(:image) }
        it { expect(subject[:image]).to include("must be persisted") }
      end
    end

    context "if hasnt any attached image should not be valid" do
      subject { described_class.run(image:) }

      let(:image) { build(:image) }

      it { expect(image).to be_valid }
      it { expect(image).not_to be_persisted }
      it { is_expected.not_to be_valid }

      context "errors" do
        subject { described_class.run(image:).errors }

        it { is_expected.to be_a(ActiveModel::Errors) }
        it { is_expected.to include(:image) }
        it { expect(subject[:image]).to include("must have an attached image") }
      end
    end
  end

  context "when called twice for the same element, should not create any new record, neither touch old" do
    subject { described_class.run(image:) }

    let(:image) { create(:image, :with_attached_image) }

    it { expect(image).to be_valid }
    it { expect(image).to be_persisted }
    it { is_expected.to be_valid }
    it { expect(image.children).to be_empty }

    context "errors" do
      subject { described_class.run(image:).errors }

      it { is_expected.to be_a(ActiveModel::Errors) }
      it { is_expected.to be_empty }
    end

    context "after 1st run" do
      subject { described_class.run(image:) }

      it "image should have a child image" do
        expect { subject }.to change { image.children.count }.by(number_of_variants)
      end
    end

    context "running twice" do
      def run
        described_class.run(image:)
      end

      context "after first run, nothing should be done" do
        before { run }

        it { expect(image.children.count).to eq number_of_variants }
        it { expect { run }.not_to(change { image.children.count }) }
        it { expect { run }.not_to(change { image.reload.updated_at }) }
        it { expect { run }.not_to(change { image.children.order(:id).first.reload.updated_at }) }

        context "second run" do
          subject { run }

          it { expect { subject }.not_to(change { image.children.count }) }
          it { is_expected.to be_valid }
          it { expect(subject.errors).to be_empty }
        end
      end
    end
  end
end
