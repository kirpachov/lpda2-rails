# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::CopyTag, type: :interaction do
  context '#execute' do
    let!(:tag) { create(:menu_tag) }
    let!(:current_user) { create(:user) }
    let(:old) { tag }
    let(:params) { { old:, current_user: } }
    subject { described_class.run(params) }

    context 'basic' do
      it 'creates a new tag' do
        expect { subject }.to change(Menu::Tag, :count).by(1)
      end

      it 'call is valid' do
        expect(subject).to be_valid
      end

      it 'returns tag' do
        expect(subject.result).to be_a(Menu::Tag)
        expect(subject.result).to be_valid
        expect(subject.result).to be_persisted
      end

      it 'enqueue a job to save the changes with current user info' do
        allow(SaveModelChangeJob).to receive(:perform_async).with(include( "user_id" => current_user.id ))
        subject
      end
    end

    context 'should copy name and description translations' do
      before do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            old.name = "Name in #{locale}"
            old.description = "Description in #{locale}"
          end
        end

        old.save!
      end

      context 'checking mock data' do
        it 'has name and description in all available locales' do
          I18n.available_locales.each do |locale|
            Mobility.with_locale(locale) do
              expect(old.name).to eq("Name in #{locale}")
              expect(old.description).to eq("Description in #{locale}")
            end
          end
        end
      end

      it 'copies name and description translations' do
        expect(subject.result.name).to eq(old.name)
        expect(subject.result.description).to eq(old.description)
      end

      it 'name in all available locales' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.name).to eq("Name in #{locale}")
          end
        end
      end

      it 'description in all available locales' do
        I18n.available_locales.each do |locale|
          Mobility.with_locale(locale) do
            expect(subject.result.description).to eq("Description in #{locale}")
          end
        end
      end
    end

    context 'copies status' do
      it 'copies status' do
        expect(subject.result.status).to eq(old.status)
      end
    end

    context 'copies color' do
      before { old.update!(color: '#ff0000') }

      it 'copies color' do
        expect(subject.result.reload.color).to eq(old.color)
        expect(subject.result.color).to eq('#ff0000')
      end
    end

    context 'copies other' do
      before { old.update!(other: { foo: :bar }) }

      it 'copies other' do
        expect(subject.result.reload.other).to eq(old.other)
        expect(subject.result.other).to eq({ 'foo' => 'bar' })
      end
    end

    context 'when tag has image and providing {copy_image: "full"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { tag.image = image }
      let(:params) { { old:, current_user:, copy_image: "full" } }

      it { expect(subject.result.image).to be_present }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.to change { Image.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Blob.count }.by(1) }
      it { expect { subject }.to change { ActiveStorage::Attachment.count }.by(1) }

      it { expect(subject.result.image.url).not_to eq tag.image.url }

      it 'should have a different image' do
        new = subject.result
        tag.image.attached_image.blob.purge
        tag.image.attached_image.destroy!
        tag.image.destroy!
        tag.destroy!

        expect(new.image.url).to be_present
        expect(new.image.attached_image.blob).to be_present
      end
    end

    context 'when tag has image and providing {copy_image: "link"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { tag.image = image }
      let(:params) { { old:, current_user:, copy_image: "link" } }

      it { expect(subject.result.image).to be_present }

      it { expect(subject.errors).to be_empty }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }

      it { expect(subject.result.image.url).to eq tag.image.url }
      it { expect(subject.result.image.id).to eq tag.image.id }
    end

    context 'when tag has image and providing {copy_image: "none"}' do
      let!(:image) { create(:image, :with_attached_image) }
      before { tag.image = image }
      let(:params) { { old:, current_user:, copy_image: "none" } }

      it { expect(subject.result.image).to be_nil }
      it { expect(subject.result.reload.image).to be_nil }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
    end

    context 'when tag has image record associated but without actual blob attached' do
      let!(:image) { create(:image) }
      before { tag.image = image }

      it { expect(subject.result.image).not_to be_present }

      it { expect { subject }.not_to change { Image.count } }
      it { expect { subject }.not_to change { ActiveStorage::Blob.count } }
      it { expect { subject }.not_to change { ActiveStorage::Attachment.count } }
    end
  end
end