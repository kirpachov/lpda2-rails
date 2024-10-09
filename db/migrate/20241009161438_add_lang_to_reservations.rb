# frozen_string_literal: true

class AddLangToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :lang, :text, null: false, default: "en"
  end
end
