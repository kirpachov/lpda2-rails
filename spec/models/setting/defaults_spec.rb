# frozen_string_literal: true

require "rails_helper"

RSpec.describe Setting::DEFAULTS do
  it { is_expected.to be_a(Hash) }
  it { is_expected.to be_a(ActiveSupport::HashWithIndifferentAccess) }
  it { is_expected.to be_frozen }
  it { is_expected.not_to be_empty }

  it "does not repeat keys" do
    expect(subject.keys.uniq).to match_array(subject.keys)
  end

  it "alls be valid Setting" do
    subject.each do |key, setting_data|
      setting = Setting.new(setting_data.except(:default).merge(key:))
      setting.validate
      expect(setting.errors).to be_empty
      expect(setting).to be_valid
      expect(setting.save).to eq true
    end
  end

  %i[default_language].each do |key|
    it "has a #{key} setting" do
      expect(subject[key]).to be_a(Hash)
      expect(subject[key.to_s]).to be_a(Hash)
      expect(subject[key.to_sym]).to be_a(Hash)
    end
  end
end
