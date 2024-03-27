# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Preference::DEFAULTS do
  it { is_expected.to be_a(Hash) }
  it { is_expected.to be_a(HashWithIndifferentAccess) }
  it { is_expected.to be_frozen }
  it { is_expected.not_to be_empty }

  it 'does not repeat keys' do
    expect(subject.keys.uniq).to match_array(subject.keys)
  end

  it 'alls be valid Preference' do
    user = create(:user)
    user.preferences.destroy_all

    subject.each do |key, preference_data|
      preference = Preference.new(preference_data.except(:default).merge(key:, user:))
      expect(preference).to be_valid
      expect(preference.errors).to be_empty
      expect(preference.save).to be true
    end
  end

  %i[language known_languages timezone].each do |key|
    it "has a #{key} preference" do
      expect(subject[key]).to be_a(Hash)
      expect(subject[key.to_s]).to be_a(Hash)
      expect(subject[key.to_sym]).to be_a(Hash)
    end
  end
end
