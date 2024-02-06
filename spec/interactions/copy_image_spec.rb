# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CopyImage, type: :interaction do
  before { ActiveJob::Base.queue_adapter = :test }

  context '#execute' do
    context 'basic' do
      let!(:image) { create(:image, :with_attached_image) }
      let!(:current_user) { create(:user) }

      subject { described_class.run(old: image, current_user: current_user) }

      it 'creates a new image' do
        expect { subject }.to change(Image, :count).by(1)
      end

      it 'call is valid' do
        expect(subject).to be_valid
      end

      it 'returns image' do
        expect(subject.result).to be_a(Image)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      it 'creates a ActiveRecord::Blob' do
        expect { subject }.to change(ActiveStorage::Blob, :count).by(1)
      end

      it 'creates a ActiveStorage::Attachment' do
        expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it 'has nothing to do with the original image' do
        new_image = subject.result
        image.attached_image.blob.purge
        image.attached_image.destroy!
        image.destroy!

        expect(new_image.attached_image.blob.filename).to be_present
      end

      it 'enqueue a job to save the changes with current user info' do
        allow(SaveModelChangeJob).to receive(:perform_async).with({ "change_type" => "create", "changed_fields" => ["filename", "status"], "record_changes" => { "filename" => [nil, image.filename], "status" => [nil, image.status] }, "record_id" => image.id + 1, "record_type" => "Image", "user_id" => current_user.id })
        subject
      end
    end

    context 'if hasnt attached image' do
      let!(:image) { create(:image) }
      let!(:current_user) { create(:user) }

      subject { described_class.run(old: image, current_user: current_user) }

      it 'original image has no attached image' do
        expect(image.attached_image).not_to be_present
      end

      it 'creates a new image' do
        expect { subject }.to change(Image, :count).by(1)
      end

      it 'call is valid' do
        expect(subject).to be_valid
      end

      it 'returns image' do
        expect(subject.result).to be_a(Image)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      it 'does not create ActiveRecord::Blob' do
        expect { subject }.not_to change(ActiveStorage::Blob, :count)
      end

      it 'does not create ActiveStorage::Attachment' do
        expect { subject }.not_to change(ActiveStorage::Attachment, :count)
      end

      it 'has nothing to do with the original image' do
        new_image = subject.result
        # image.attached_image.blob.purge
        # image.attached_image.destroy!
        # image.destroy!

        expect(new_image.attached_image).not_to be_present
      end

      it 'enqueue a job to save the changes with current user info' do
        allow(SaveModelChangeJob).to receive(:perform_async).with({ "change_type" => "create", "changed_fields" => ["filename", "status"], "record_changes" => { "filename" => [nil, image.filename], "status" => [nil, image.status] }, "record_id" => image.id + 1, "record_type" => "Image", "user_id" => current_user.id })
        subject
      end
    end
  end
end
