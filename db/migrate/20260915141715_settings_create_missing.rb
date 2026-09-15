# frozen_string_literal: true

class SettingsCreateMissing < ActiveRecord::Migration[7.0]
  def change
    Setting.create_missing
  end
end
