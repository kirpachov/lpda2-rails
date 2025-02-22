# frozen_string_literal: true

require_relative "../../config/environment"

namespace :import do
  task :all do
    Dev::ImportAll.run!
  end

  task :images do
    Dev::ImportImages.run!
  end

  task :menu do
    Dev::Menu::ImportAll.run!
  end

  task :reservations do
    Dev::SplitAndImportReservations.run!
  end
end
