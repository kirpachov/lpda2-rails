# frozen_string_literal: true

TEST_MODEL_CHANGE_INCLUSION = 'TEST_MODEL_CHANGE_INCLUSION'
RSpec.shared_examples TEST_MODEL_CHANGE_INCLUSION do
  context 'checking test data' do
    it { expect(record).to be_valid }
    it { expect(record).to be_a(described_class) }
    it { expect(record).to be_persisted }
    it { expect { record }.to change(described_class, :count).by(1) }
  end

  it { expect(described_class.ancestors).to be_include(TrackModelChanges) }
  it { expect(described_class.reflections).to include('model_changes') }
  it { expect(described_class.reflections['model_changes']).to be_a(ActiveRecord::Reflection::HasManyReflection) }

  context 'on create' do
    before do
      allow(SaveModelChangeJob).to receive(:perform_async).and_return(true)
    end

    it do
      expect(described_class.count).to eq 0
      record
      expect(described_class.count).to eq 1
      expect(SaveModelChangeJob).to have_received(:perform_async).once
    end
  end

  context 'on update' do
    before do
      before do
        allow(SaveModelChangeJob).to receive(:perform_async).and_return(true)
        record
        record.touch
      end

      it { expect(SaveModelChangeJob).to have_received(:perform_async).twice }
    end
  end

  context 'on update' do
    before do
      before do
        allow(SaveModelChangeJob).to receive(:perform_async).and_return(true)
        record
        record.touch
        record.destroy
      end

      it { expect(SaveModelChangeJob).to have_received(:perform_async).exactly(3).times }
    end
  end
end