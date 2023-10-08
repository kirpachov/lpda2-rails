# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe Preference::DEFAULTS do
#   it { should be_a(Hash) }
#   it { should be_a(HashWithIndifferentAccess) }
#   it { should be_frozen }
#   it { should_not be_empty }

#   it 'should not repeat keys' do
#     expect(subject.keys.uniq).to match_array(subject.keys)
#   end

#   it 'should all be valid Preference' do
#     user = create(:user)
#     user.preferences.destroy_all

#     subject.each do |key, preference_data|
#       preference = Preference.new(preference_data.merge(key: key, user: user))
#       expect(preference).to be_valid
#       expect(preference.errors).to be_empty
#       expect(preference.save).to be true
#     end
#   end

#   %i[language known_languages timezone].each do |key|
#     it "should have a #{key} preference" do
#       expect(subject[key]).to be_a(Hash)
#       expect(subject[key.to_s]).to be_a(Hash)
#       expect(subject[key.to_sym]).to be_a(Hash)
#     end
#   end
# end
