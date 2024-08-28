# frozen_string_literal: true

# STRUCTURE OF Menu::Category information returned by PUBLIC controllers.
# Expects subject to be the Hash with Menu::Category information.
MENU_CATEGORY_STRUCTURE = "MENU_CATEGORY_STRUCTURE"
RSpec.shared_examples MENU_CATEGORY_STRUCTURE do
  it { is_expected.to be_a(Hash) }

  it do
    expect(subject).to include(
      id: Integer,
      status: String,
      index: Integer,
      images: Array,
      created_at: String,
      updated_at: String
    )
  end

  context "images" do
    it { expect(subject[:images]).to be_a(Array) }
    it { expect(subject[:images]).to all(be_a(Hash)) }
    it { expect(subject[:images]).to all(include(*%i[id url filename created_at updated_at])) }
  end
end
