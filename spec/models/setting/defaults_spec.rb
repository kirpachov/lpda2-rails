# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Setting::DEFAULTS do
  it { should be_a(Hash) }
  it { should be_a(HashWithIndifferentAccess) }
  it { should be_frozen }
  it { should_not be_empty }

  it 'should not repeat keys' do
    expect(subject.keys.uniq).to match_array(subject.keys)
  end

  it 'should all be valid Setting' do
    subject.each do |key, setting_data|
      setting = Setting.new(setting_data.except(:default).merge(key: key))
      setting.validate
      expect(setting.errors).to be_empty
      expect(setting).to be_valid
      expect(setting.save).to eq true
    end
  end

  %i[default_language].each do |key|
    it "should have a #{key} setting" do
      expect(subject[key]).to be_a(Hash)
      expect(subject[key.to_s]).to be_a(Hash)
      expect(subject[key.to_sym]).to be_a(Hash)
    end
  end
end
