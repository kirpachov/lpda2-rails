# frozen_string_literal: true

require "rails_helper"

RSpec.describe HasOtherJson do
  let(:record) { build(:model_change) }

  describe "#merge_other" do
    it "merges the given hash into #other" do
      record.other = { "a" => 1 }
      expect(record.merge_other("b" => 2)).to eq({ "a" => 1, "b" => 2 })
    end

    it "assigns the merged value to #other" do
      record.other = { "a" => 1 }
      record.merge_other("b" => 2)
      expect(record.other).to eq({ "a" => 1, "b" => 2 })
    end

    it "overwrites existing keys with the new values" do
      record.other = { "a" => 1 }
      record.merge_other("a" => 2)
      expect(record.other).to eq({ "a" => 2 })
    end

    it "works when #other is nil" do
      record.other = nil
      expect(record.merge_other("a" => 1)).to eq({ "a" => 1 })
    end

    it "raises when given a non-Hash value" do
      expect { record.merge_other("not a hash") }.to raise_error(RuntimeError, /Hash expected, got String/)
    end

    it "raises when given nil" do
      expect { record.merge_other(nil) }.to raise_error(RuntimeError, /Hash expected, got NilClass/)
    end
  end

  describe "#update_other" do
    let(:record) { create(:model_change) }

    it "persists the merge of #other with the given hash" do
      record.update!(other: { "a" => 1 })
      record.update_other("b" => 2)
      expect(record.reload.other).to eq({ "a" => 1, "b" => 2 })
    end

    it "returns the result of #update" do
      expect(record.update_other("a" => 1)).to be true
    end
  end
end
