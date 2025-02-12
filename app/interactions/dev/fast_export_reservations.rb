# frozen_string_literal: true

module Dev
  class FastExportReservations < ActiveInteraction::Base
    string :outdir, default: "/tmp/lpda-import-export"

    def execute
      FileUtils.mkdir_p(outdir)
      command = %(psql -d #{ActiveRecord::Base.connection_db_config.database} -c "COPY (SELECT * FROM #{Reservation.table_name}) TO STDOUT WITH CSV HEADER DELIMITER ';' ;" > #{outdir}/reservations.csv)
      puts command
      `#{command}`
    end
  end
end
