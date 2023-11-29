# frozen_string_literal: true

HAS_IMAGE_HELPER = 'HAS_IMAGE_HELPER'

RSpec.shared_examples HAS_IMAGE_HELPER do
  it { expect(described_class).to be_a(Class) }

  it { expect(subject).to be_a(ApplicationRecord) }
  it { should have_many(:image_to_records) }
  it { should have_many(:images).through(:image_to_records) }
  it { should be_valid }
  it { should be_persisted }
  it { expect(subject.images).to be_empty }
  it { expect(subject.image_to_records).to be_empty }

  context 'can add images with "<< <ImageInstance>"' do
    let(:image) { create(:image, :with_attached_image) }

    it "should change subject images count + 1" do
      expect { subject.images << image }.to change { subject.reload.images.count }.by(1)
    end

    it "should change subject images to record count + 1" do
      expect { subject.images << image }.to change { subject.reload.image_to_records.count }.by(1)
    end

    context 'after has been added' do
      before { subject.images << image }

      it { expect(subject.images).to include(image) }
      it { expect(image.image_to_records).to include(subject.image_to_records.find_by(image: image)) }
      it { expect(image.image_to_records.find_by(image: image).record).to eq(subject) }
      it { expect(image.image_to_records.find_by(image: image).record_id).to eq(subject.id) }

      context 'cant add the same image twice' do
        it "should fail." do
          expect { subject.images << image }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  context 'when trying to attach a image that does not have any attached_image' do
    let(:image) { create(:image) }

    it "should fail." do
      expect { subject.images << image }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when element is deleted, association to image should be deleted but the image itself no.' do
    let(:image) { create(:image, :with_attached_image) }
    before { subject.images << image }

    it { expect { subject.destroy }.not_to change(Image, :count) }
    it { expect { subject.destroy }.to change(ImageToRecord, :count).by(-1) }
  end
end