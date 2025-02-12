# frozen_string_literal: true

module Dev
  class FastImportReservations < ActiveInteraction::Base
    string :csv_location, default: "/tmp/lpda-import-export/reservations.csv"

    def execute
      raise "File not found: #{csv_location}" unless File.exist?(csv_location)

      command = %(psql -d #{ActiveRecord::Base.connection_db_config.database} -c "COPY #{Reservation.table_name} FROM '#{csv_location}' DELIMITER ';' CSV HEADER;")
      puts command
      `#{command}`
    end
  end
end
