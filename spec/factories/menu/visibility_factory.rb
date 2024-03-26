# frozen_string_literal: true

FactoryBot.define do
  factory :menu_visibility, class: 'Menu::Visibility' do
    public_visible { false }
    private_visible { false }

    public_from { nil }
    public_to { nil }
    private_from { nil }
    private_to { nil }

    trait :public_visible do
      public_visible { true }
    end

    trait :private_visible do
      private_visible { true }
    end
  end
end
