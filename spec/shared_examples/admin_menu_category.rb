# frozen_string_literal: true

# STRUCTURE OF Menu::Category information returned by admin controllers.
# Expects subject to be the Hash with Menu::Category information.
ADMIN_MENU_CATEGORY = 'ADMIN_MENU_CATEGORY'
RSpec.shared_examples ADMIN_MENU_CATEGORY do |options = {}|
  it { should be_a(Hash) }
  it {
    should include(
      id: Integer,
      status: String,
      index: Integer,
      secret: String,
      images: Array,
      created_at: String,
      updated_at: String
    )
  }

  unless options[:skip_visibility]
    it { should include(menu_visibility_id: Integer) }
    it { should include(visibility: Hash) }

    context 'visibility' do
      it { expect(subject[:visibility]).to be_a(Hash) }
      it {
        expect(subject[:visibility]).to include(*%i[public_visible public_from public_to private_visible private_from
                                                    private_to created_at updated_at id])
      }
    end
  end

  context 'images' do
    it { expect(subject[:images]).to be_a(Array) }
    it { expect(subject[:images]).to all(be_a(Hash)) }
    it { expect(subject[:images]).to all(include(*%i[id url filename created_at updated_at])) }
    # it { should all(contain_exactly(*%i[id url filename created_at updated_at])) }
  end
end
