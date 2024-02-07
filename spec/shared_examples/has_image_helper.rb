# frozen_string_literal: true

# Note: below is defined HAS_IMAGE_HELPER

HAS_IMAGES_HELPER = 'HAS_IMAGES_HELPER'

RSpec.shared_examples HAS_IMAGES_HELPER do
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

  context 'elements are ordered by :position field in ImageToRecord' do
    let(:images) { create_list(:image, 3, :with_attached_image) }
    before { subject.images << images }
    let(:image_to_records) { subject.image_to_records.order(:position) }

    it { expect(subject.images.map(&:id)).to eq(images.map(&:id)) }
    it { expect(subject.image_to_records).to eq(image_to_records) }
    it { subject.images.each_with_index { |_, index| expect(subject.images[index].id).to eq images[index]&.id } }

    context 'moving the last one as the first one' do
      before { subject.move_image(2, 0) }

      it { expect(subject.reload.images.map(&:id)).to eq([images.third.id, images.first.id, images.second.id]) }
    end

    context 'moving image should update the updated_at field of the image_to_records' do
      let(:images) { create_list(:image, 3, :with_attached_image) }
      before { subject.images = images }

      it 'banana' do
        subject
        expect { subject.move_image(2, 0) }.to change { ImageToRecord.order(:id).pluck(:updated_at) }
      end
    end

    context 'moving the first one as the last one' do
      before { subject.move_image(0, 2) }

      it { expect(subject.reload.images.map(&:id)).to eq([images.second.id, images.third.id, images.first.id]) }
    end

    context 'moving the first one as the middle one' do
      before do
        subject.move_image(0, 1)
      end

      it { expect(subject.reload.images.map(&:id)).to eq([images.second.id, images.first.id, images.third.id]) }
    end

    context 'moving the last one as the middle one' do
      before do
        subject.move_image(2, 1)
      end

      it { expect(subject.reload.images.map(&:id)).to eq([images.first.id, images.third.id, images.second.id]) }
    end
  end
end

HAS_IMAGE_HELPER = 'HAS_IMAGE_HELPER'

RSpec.shared_examples HAS_IMAGE_HELPER do
  it { expect(described_class).to be_a(Class) }

  it { expect(subject).to be_a(ApplicationRecord) }
  it { should have_one(:image_to_record) }
  it { should have_one(:image).through(:image_to_record) }
  it { should be_valid }
  it { should be_persisted }
  it { expect(subject.image).to be_nil }
  it { expect(subject.image_to_record).to be_nil }

  context 'can add image with "= <ImageInstance>"' do
    let(:image) { create(:image, :with_attached_image) }

    it "should change subject image" do
      expect { subject.image = image }.to change { subject.reload.image }.from(nil).to(image)
    end

    it "should change image to record" do
      expect { subject.image = image }.to change { subject.reload.image_to_record }.from(nil).to(be_a(ImageToRecord))
    end

    it "should create image to record" do
      expect { subject.image = image }.to change { ImageToRecord.count }.by(1)
    end

    context 'after has been added' do
      before { subject.image = image }

      it { expect(subject.image).to eq(image) }
      # it { expect(image.image_to_record).to include(subject.image_to_record.find_by(image: image)) }
      it { expect(image.image_to_records.find_by(image: image).record).to eq(subject) }
      it { expect(image.image_to_records.find_by(image: image).record_id).to eq(subject.id) }

      it 'can add the same image twice' do
        expect { subject.image = image }.not_to raise_error
      end
    end
  end

  context 'when trying to attach a image that does not have any attached_image' do
    let(:image) { create(:image) }

    it "should fail." do
      expect { subject.image = image }.not_to raise_error
    end

    it "should not update image." do
      expect { subject.image = image }.not_to change { subject.reload.image }
    end
  end

  context 'when element is deleted, association to image should be deleted but the image itself no.' do
    let(:image) { create(:image, :with_attached_image) }
    before { subject.image = image }

    it { expect { subject.destroy }.not_to change(Image, :count) }
    it { expect { subject.destroy }.to change(ImageToRecord, :count).by(-1) }
  end
end