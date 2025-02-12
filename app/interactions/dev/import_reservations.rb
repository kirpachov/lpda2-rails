# frozen_string_literal: true

module Dev
  class ImportReservations < ActiveInteraction::Base
    string :csv_location, default: Rails.root.join("migration", "records", "reservations.csv").to_s
    boolean :verbose, default: false

    def execute
      row_index = 0
      Rails.logger.silence(verbose ? Logger::DEBUG : Logger::WARN) do
        CSV.foreach(csv_location, headers: true, col_sep: ";", liberal_parsing: true) do |row|
          row_index += 1

          next if persisted_reservations.include?(row["id"].to_s)

          reservation = Reservation.new(
            member_id: row["id"],
            fullname: "#{row["name"]} #{row["surname"]}",
            email: row["email"].to_s.gsub(/\s+/, ""),
            phone: row["telephone"].to_s.gsub(/\s+/, ""),
            datetime: DateTime.parse(row["reservationDate"]) - 1.hour, # removing one hour to have UTC time.
            table: row["table"].to_s.present? && row["table"] != "\\N" ? row["table"] : nil,
            adults: row["people"].to_i,
            children: 0,
            other: {
              imported_at: Time.current,
              imported_from: csv_location,
              original_row: row.to_h,
            },
            secret: row["token"].to_s.present? && row["token"] != "\\N" ? tokens[row["token"]] : nil,
            notes: row["notes"],
            lang: row["lang"].to_s.downcase.in?(%w[en it]) ? row["lang"].to_s.downcase : "en",
          )

          reservation.status = remap_status(row["status"], row)

          next if reservation.valid? && reservation.save

          Rails.logger.error("Error saving reservation: #{reservation.errors.full_messages} at line #{row_index} (old id #{row["id"]})")
        end
      end
    end

    # Returns hash where
    # { tokenId => secret }
    # where tokenID is a integer and secret is a string
    def tokens
      @tokens ||= CSV.open(
        Rails.root.join("migration/records/tokens.csv"), headers: true, col_sep: ";", liberal_parsing: true
      ).to_a.map(&:to_h).index_by { |j| j["id"] }.to_h { |k, v| [k, v["token"]] }
    end

    def persisted_reservations
      @persisted_reservations ||= Reservation.all.where("member_id IS NOT NULL").pluck(:member_id)
    end

    def notify(message)
      puts message
      Rails.logger.info(message)
    end

    def remap_status(old_status, record)
      # | accomodato   |
      # | eliminata    |
      # | non arrivato |
      # | prossimo     |
      case old_status
      when "accomodato" then "arrived"
      when "eliminata" then "cancelled"
      when "non arrivato" then "noshow"
      when "prossimo" then "active"
      else
        Rails.logger.warn "Unknown status: #{old_status} for record: #{record.inspect}"
        "active"
      end
    end
  end
end
