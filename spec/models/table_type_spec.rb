# frozen_string_literal: true

require "rails_helper"

RSpec.describe TableType, type: :model do
  it { expect(build(:table_type)).to be_valid }
  it { expect(create(:table_type)).to be_persisted }

  it { expect(build(:table_type, default_people_per_turn: 0)).to be_invalid }
  it { expect(build(:table_type, default_people_per_turn: -1)).to be_invalid }
  it { expect(build(:table_type, default_people_per_turn: 1)).to be_valid }
  it { expect(build(:table_type, default_people_per_turn: 10)).to be_valid }
end
