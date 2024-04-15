# frozen_string_literal: true

module V1::Admin::Menu
  # Export menu utils
  class ExportController < ApplicationController
    def export
      # send_data Menu::Ingredient.all.to_csv, filename: "ingredients.csv"
      @file = ::Menu::ExportMenu.run!

      send_file @file, filename: "menu.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    end
  end
end
