# frozen_string_literal: true

FactoryBot.define do
  factory :model_change, class: "Log::ModelChange" do
    # record_type {  }
    # record_id {  }
    record { create(:user) }
    change_type { "create" }
    version { 1 }
    # user { create(:user) }
    changed_fields { record.attributes.slice(*record.class.column_names).keys }
    record_changes { record.attributes.slice(*record.class.column_names) }
  end
end
