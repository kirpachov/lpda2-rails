# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  include_context FILES_HELPER

  def valid_statuses
    %w[active deleted]
  end

  def valid_tags
    %w[blur]
  end

  context 'can be translated' do
    subject { create(:image) }

    include_examples MODEL_MOBILITY_SPEC, field: :title
    include_examples MODEL_MOBILITY_SPEC, field: :description
  end

  context 'associations' do
    it { should have_many(:image_to_records) }
    it { should belong_to(:original).optional }
    it { should have_one_attached(:attached_image) }
    it { should have_many(:children).class_name('Image').with_foreign_key(:original_id) }

    context 'children' do
      context 'can be added with "<<"' do
        subject { original }

        let(:original) { create(:image, :with_attached_image) }
        let(:child) { create(:image, :with_attached_image, tag: :blur) }

        it { expect { subject.children << child }.to change { subject.children.count }.by(1) }

        context 'after adding' do
          before { subject.children << child }

          it { expect(subject.children).to include(child) }
          it { expect(child.original).to eq(subject) }
          it { expect(child.original_id).to eq(subject.id) }

          context 'if original is deleted' do
            before { subject.destroy! }
            it { expect { original.reload }.to raise_error(ActiveRecord::RecordNotFound) }
            it { expect { child.reload }.to raise_error(ActiveRecord::RecordNotFound) }
          end

          context 'if child is deleted' do
            before { child.destroy! }
            it { expect(original.reload).to eq(original) }
            it { expect { child.reload }.to raise_error(ActiveRecord::RecordNotFound) }
          end
        end
      end
    end

    context 'attached_image' do
      subject { create(:image) }
      it { should be_valid }
      it { should be_persisted }
      it { expect(subject.attached_image).to be_an_instance_of(ActiveStorage::Attached::One) }
      it { expect { subject.attached_image.attach(io: File.open(spec_image), filename: 'miao miao') }.not_to raise_error }
    end
  end

  context 'validations' do
    it { should validate_presence_of(:filename) }
    it { should_not allow_value(nil).for(:filename) }
    it { should_not allow_value('').for(:filename) }

    context 'status' do
      it { should allow_value(valid_statuses.sample).for(:status) }

      it { should_not allow_value('some_invalid_status').for(:status) }

      it { expect(subject.defined_enums.keys).to include('status') }

      it { should validate_inclusion_of(:status).in_array(valid_statuses) }
    end

    context 'tag' do
      it { should allow_value(valid_tags.sample).for(:tag) }

      it { should_not allow_value('some_invalid_tag').for(:tag) }

      it { expect(subject.defined_enums.keys).to include('tag') }

      it { should validate_inclusion_of(:tag).in_array(valid_tags) }
    end

    context 'tag should not be nil when original is set' do
      subject { build(:image, :with_original, tag: nil) }

      it { should_not be_valid }
      it { should_not be_persisted }
      it { expect(subject.original).to be_an_instance_of(Image) }
      it { expect { subject.update!(tag: nil) }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'tag can be nil when original is not set' do
      subject { create(:image) }

      it { should be_valid }
      it { should be_persisted }
      it { expect(subject.original).to be_nil }
      it { expect { subject.update!(tag: nil) }.not_to raise_error }
    end
  end

  context 'instance methods' do
    context '#is_original?' do
      subject { build(:image) }
      it { should be_valid }
      it { should_not be_persisted }
      it { should be_is_original }
      it { expect(subject).to respond_to(:is_original?) }
      it { expect(subject.original).to be_nil }
      it { expect(subject.original_id).to be_nil }
    end

    context '#blur_image' do
      subject { create(:image, :with_attached_image) }
      it { should be_valid }
      it { should be_persisted }
      it { should be_is_original }
      it { expect(subject).to respond_to(:blur_image) }
      it { expect(subject.original).to be_nil }
      it { expect(subject.original_id).to be_nil }
      it { expect(subject.children).to be_empty }

      context 'after run' do
        subject { create(:image, :with_attached_image) }
        it { expect(subject.children).to be_empty }
        it { expect { subject.blur_image }.to change { subject.children.count }.by(0) }
        it { expect(subject.blur_image).to be nil }
      end
    end

    context '#url' do
      let(:image) { create(:image, :with_attached_image) }
      subject { image }
      it { should be_valid }
      it { should be_persisted }
      it { should be_is_original }
      it { expect(subject).to respond_to(:url) }

      context 'after run' do
        subject { image.url }

        it { should be_a(String) }
        it { should include(Config.base_url) }
      end
    end
  end

  context 'class methods' do
    context 'scope .original should return all items where original_id is null' do
      before do
        create(:image, :with_attached_image)
        create(:image, :with_attached_image, :with_original)
      end

      subject { described_class.original }
      it { expect(subject.to_sql).to include('WHERE "images"."original_id" IS NULL') }
      it { expect(subject.count).to eq(2) }
      it { expect(described_class.count).to eq 3 }
      it { subject.each { |item| expect(item).to be_is_original } }
      it { expect(subject.pluck(:original_id).uniq).to eq [nil] }
    end

    context 'scope .not_original should return all items where original_id is not null' do
      it { expect(described_class).to respond_to(:not_original) }
      context 'when some items exist' do
        before do
          create(:image, :with_attached_image)
          create(:image, :with_attached_image, :with_original)
        end

        subject { described_class.not_original }
        it { expect(subject.to_sql).to include('WHERE "images"."original_id" IS NOT NULL') }
        it { expect(subject.count).to eq(1) }
        it { expect(described_class.count).to eq 3 }
        it { subject.each { |item| expect(item).not_to be_is_original } }
        it { expect(subject.pluck(:original_id).uniq).not_to eq [nil] }
      end
    end

    context 'scope .visible should exclude deleted items' do
      before do
        create(:image, status: :active)
        create(:image, status: :deleted)
      end

      it { expect(Image.count).to eq 2 }
      it { expect(Image.active.count).to eq 1 }
      it { expect(Image.deleted.count).to eq 1 }
      it { expect(Image.visible.count).to eq 1 }
    end

    context 'scope .with_attached_image should return only items that have attached image' do
      before do
        create(:image, :with_attached_image)
        create(:image, :with_attached_image)
        create(:image)
      end

      it { expect(Image.count).to eq 3 }
      it { expect(Image.with_attached_image.count).to eq 2 }
      it { expect(Image.with_attached_image.pluck(:id).uniq.sort!).to eq Image.with_attached_image.pluck(:id).sort! }
    end
  end
end
