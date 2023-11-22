# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Menu::Category, type: :model do

  def valid_statuses
    Menu::Category::VALID_STATUSES
  end

  def min_secret_length
    Menu::Category::SECRET_MIN_LENGTH
  end

  context 'should have valid factories' do
    subject { build(:menu_category) }
    it { should be_valid }
    it { expect { subject.save! }.not_to raise_error }
  end

  context 'validations' do
    context 'basic' do
      subject { build(:menu_category) }
      before { allow_any_instance_of(Menu::Category).to receive(:assign_defaults).and_return(true) }

      it { should be_valid }

      it { should validate_presence_of(:status) }
      it { should validate_inclusion_of(:status).in_array(valid_statuses) }
      it { should_not allow_value(nil).for(:status) }
      it { should_not allow_value('some_invalid_status').for(:status) }

      it { should validate_presence_of(:secret) }
      it { should_not allow_value(nil).for(:secret) }
      it { should_not allow_value("a").for(:secret) }
      it { should allow_value("a" * min_secret_length).for(:secret) }
      it { should validate_uniqueness_of(:secret).case_insensitive }

      it { should allow_value(nil).for(:secret_desc) }
      it { should validate_uniqueness_of(:secret_desc).case_insensitive.allow_nil }

      it { should_not allow_value(nil).for(:other) }
    end

    %i[secret secret_desc].each do |field|
      context "#{field} should be a string that can be put in a link" do
        subject { build(:menu_category) }
        it { should allow_value("a" * min_secret_length).for(field) }
        it { should allow_value("bananagang123123123").for(field) }
        it { should allow_value("ba-na-na-gang-123-321").for(field) }
        it { should allow_value("MenuInterattivo").for(field) }
        it { should allow_value("MenuInterattivo-").for(field) }
        it { should allow_value("MenuInterattivo_").for(field) }

        it { should_not allow_value("MenuInterattivo,").for(field) }
        it { should_not allow_value("MenuInterattivo.").for(field) }
        it { should_not allow_value("MenuInterattivo;").for(field) }
        it { should_not allow_value("MenuInterattivo:").for(field) }
        it { should_not allow_value("banana gang").for(field) }
        it { should_not allow_value("bananagang!").for(field) }
        it { should_not allow_value("bananagang%").for(field) }
        it { should_not allow_value("bananagang&").for(field) }
        it { should_not allow_value("bananagang/").for(field) }
        it { should_not allow_value("bananagang$").for(field) }
        it { should_not allow_value("bananagang£").for(field) }
        it { should_not allow_value("bananagang\"").for(field) }
        it { should_not allow_value("bananagang|").for(field) }
        it { should_not allow_value("bananagang'").for(field) }
        it { should_not allow_value("bananagang^").for(field) }
        it { should_not allow_value("bananagang]").for(field) }
        it { should_not allow_value("bananagang[").for(field) }
        it { should_not allow_value("bananagang#").for(field) }
        it { should_not allow_value("bananagang*").for(field) }
        it { should_not allow_value("bananagang+").for(field) }
        it { should_not allow_value("bananagang}").for(field) }
        it { should_not allow_value("bananagang{").for(field) }
        it { should_not allow_value("bananagang°s").for(field) }
      end
    end

    context 'should not be able to create two elements with same secret' do
      let(:original) { create(:menu_category) }
      subject { Menu::Category.new(original.as_json(except: [:id, 'id'])) }

      it { expect(original).to be_valid }
      it { expect(original).to be_persisted }

      it { expect(subject).not_to be_valid }
      it { expect(subject).not_to be_persisted }
      it { expect(subject.validate).to be false }
      it { expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid) }
      it 'should have errors in :secret field' do
        subject.validate
        expect(subject.errors[:secret]).to be_a(Array)
        expect(subject.errors[:secret].count).to be > 0
      end
    end
  end

  context 'associations' do
    it { should belong_to(:menu_visibility).dependent(:destroy) }
    # it { should belong_to(:parent) }
    context 'parent' do
      subject { build(:menu_category, parent: build(:menu_category)) }
      it { should be_valid }
      it { expect(subject.save!).to be true }
      it { expect { subject.save! }.not_to raise_error }
    end
  end

  context 'instance methods' do
    context '#visibility should alias to menu_visibility' do
      subject { create(:menu_category) }
      it { should respond_to(:visibility) }
      it { should respond_to(:menu_visibility) }
      it { expect(subject.visibility).to eq subject.menu_visibility }
    end
  end
end
