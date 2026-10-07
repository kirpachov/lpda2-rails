# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchRecords, type: :interaction do
  describe "#param_false?" do
    subject { described_class.new(params:) }

    context "when the param value is a falsy string" do
      %w[false FALSE 0 no NO f F].each do |value|
        context "when value is #{value.inspect}" do
          let(:params) { { active: value } }

          it { expect(subject.param_false?(:active)).to be true }
        end
      end
    end

    context "when the param value is a truthy string" do
      let(:params) { { active: "true" } }

      it { expect(subject.param_false?(:active)).to be false }
    end

    context "when the param is missing" do
      let(:params) { {} }

      it { expect(subject.param_false?(:active)).to be false }
    end

    context "when the param value is nil" do
      let(:params) { { active: nil } }

      it { expect(subject.param_false?(:active)).to be false }
    end

    context "when given multiple param names" do
      let(:params) { { first: "true", second: "false" } }

      it "returns true if any of them is false" do
        expect(subject.param_false?(:first, :second)).to be true
      end

      it "returns false if none of them is false" do
        params_without_false = { first: "true", second: "true" }
        expect(described_class.new(params: params_without_false).param_false?(:first, :second)).to be false
      end
    end

    context "when given an array of param names" do
      let(:params) { { first: "true", second: "false" } }

      it { expect(subject.param_false?(%i[first second])).to be true }
    end
  end
end
