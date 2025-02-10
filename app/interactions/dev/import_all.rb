# frozen_string_literal: true

module Dev
  class ImportAll < ActiveInteraction::Base

    boolean :verbose, default: false

    def execute
      ImportImages.run!(verbose:)
      Menu::ImportAll.run!(verbose:)
    end
  end
end
