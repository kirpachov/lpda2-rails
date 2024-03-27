# frozen_string_literal: true

MODEL_MOBILITY_EXAMPLES = 'MODEL_MOBILITY_EXAMPLES'

RSpec.shared_examples MODEL_MOBILITY_EXAMPLES do |args = {}|
  it { is_expected.to respond_to(:text_translations) }
  it { is_expected.to respond_to(args[:field]) }
  it { is_expected.to respond_to("#{args[:field]}_backend") }
  it { is_expected.to respond_to("#{args[:field]}=") }
  it { is_expected.to respond_to("#{args[:field]}?") }

  it 'checking mock data: should be a existing instance' do
    expect(subject).to be_a(ActiveRecord::Base)
    expect(subject).to be_valid
    expect(subject).to be_persisted
    expect(subject).to respond_to(:text_translations)
  end

  it 'can be translated' do
    subject.send("#{args[:field]}=", 'test')
    subject.save!
    subject.reload
    expect(subject.send(args[:field])).to eq 'test'
    expect(subject.send("#{args[:field]}_backend").read(I18n.locale)).to eq 'test'
    i18n = (I18n.available_locales - [I18n.locale]).sample

    return if i18n.nil?

    I18n.with_locale(i18n) do
      expect(subject.send(args[:field])).to eq nil
      expect(subject.send("#{args[:field]}_backend").read(i18n)).to eq nil
    end
  end

  it "has locale_accessors for #{args[:field]}" do
    I18n.available_locales.each do |locale|
      expect(subject).to respond_to("#{args[:field]}_#{locale}")
      expect(subject).to respond_to("#{args[:field]}_#{locale}=")
    end
  end

  it "has attribute_methods for #{args[:field]}" do
    expect { subject.translated_attributes }.not_to raise_error
    expect(subject.translated_attributes).to be_a(Hash)
    expect(subject.translated_attributes).to include(args[:field].to_s)
  end

  it "can find elements with exact match for #{args[:field]}" do
    subject.send("#{args[:field]}=", 'test')
    subject.save!
    items = subject.class.i18n.where(args[:field] => 'test')
    expect(items.count).to be > 0
    expect(items).to include(subject)
  end

  pending "can find elements with ilike match for #{args[:field]}" do
    # TODO: test this kind of query works
    # subject.class.i18n { name.matches("foo") }
    # subject.class.i18n { name.matches("foo").and(content.matches("bar")) }

    subject.send("#{args[:field]}=", 'test')
    items = subject.class.i18n { send(args[:field]).matches('%te%') }
    expect(items.count).to be > 0
    expect(items).to include(subject)
  end
end
