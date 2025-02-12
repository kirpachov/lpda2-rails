# frozen_string_literal: true

module Dev
  class SplitAndImportReservations < ActiveInteraction::Base
    integer :concurrency, default: 5
    integer :chunks, default: 10

    string :csv_location, default: Rails.root.join("migration", "records", "reservations.csv").to_s
    string :output_dir, default: Rails.root.join("tmp", "lpda-import").to_s

    boolean :cache, default: false

    boolean :verbose, default: false

    def execute
      puts "Preparing output directory..."
      prepare_output_directory
      puts "Splitting CSV..."
      files = split_csv
      puts "Importing files in parallel..."
      import_files_in_parallel(files)
    end

    private

    def prepare_output_directory
      FileUtils.rm_rf(output_dir) unless cache
      FileUtils.mkdir_p(output_dir)
    end

    def split_csv
      files = []

      CSV.open(csv_location, headers: true, col_sep: ";", liberal_parsing: true) do |csv|
        headers = csv.first.headers
        chunk_size = (csv.count.to_f / chunks).ceil
        csv.rewind # Riporta il puntatore all'inizio del file
        csv.shift # Salta le intestazioni di nuovo

        csv.each_slice(chunk_size).with_index do |slice, index|
          file_path = File.join(output_dir, "reservations_part_#{index + 1}.csv")

          next if cache && File.exist?(file_path)

          CSV.open(file_path, "w", col_sep: ";", quote_char: '"', force_quotes: true) do |out_csv|
            out_csv << headers
            slice.each { |row| out_csv << row }
          end

          files << file_path
        end
      end

      files
    end

    def import_files_in_parallel(files)
      Parallel.each(files, in_processes: concurrency) do |file|
        puts "Importing #{file}..."
        ImportReservations.run!(csv_location: file, verbose:)
      end
    end
  end
end
