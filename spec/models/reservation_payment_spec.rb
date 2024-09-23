# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationPayment, type: :model do
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.not_to allow_value(nil).for(:value) }
  it { is_expected.not_to allow_value(-1).for(:value) }
  it { is_expected.not_to allow_value(0).for(:value) }
  it { is_expected.to allow_value(1).for(:value) }
  it { is_expected.to allow_value(100).for(:value) }

  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:hpp_url) }
end
