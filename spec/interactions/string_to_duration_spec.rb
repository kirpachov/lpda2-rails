# frozen_string_literal: true

require "rails_helper"

RSpec.describe StringToDuration, type: :interaction do
  [
    { string: "1 second", expected: 1.second },
    { string: "1 seconds", expected: 1.second },
    { string: "1 minute", expected: 1.minute },
    { string: "1 minutes", expected: 1.minute },
    { string: "1 hour", expected: 1.hour },
    { string: "1 hours", expected: 1.hour },
    { string: "1 day", expected: 1.day },
    { string: "1 days", expected: 1.days },
    { string: "1 week", expected: 1.week },
    { string: "1 weeks", expected: 1.week },
    { string: "1 month", expected: 1.month },
    { string: "1 months", expected: 1.month },
    { string: "1 year", expected: 1.year },
    { string: "1 years", expected: 1.year },

    { string: "1 banana", expected: nil },
    { string: "1", expected: nil },
    { string: "10 ", expected: nil },
    { string: "day ", expected: nil },
    { string: "10 cocomeri", expected: nil },
    { string: "10.days", expected: nil },
    { string: "10-days ", expected: nil },
    { string: "10days ", expected: nil },
    { string: "10!days ", expected: nil }
  ].each do |test|
    context "when string is #{test[:string].inspect}" do
      subject(:interaction) { described_class.run(string: test[:string]).result }

      it { is_expected.to eq(test[:expected]) }
      it { expect { interaction }.not_to raise_error }

      if test[:expected].nil?
        it { expect(interaction).to be_nil }
      else
        it { expect(interaction).to be_a(ActiveSupport::Duration) }
      end
    end
  end
end
