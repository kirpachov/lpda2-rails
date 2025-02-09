# frozen_string_literal: true

class CreateReservationTurnMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_turn_messages do |t|
      t.date :from_date,
             comment: %(When user tries to reserve for the associated reservation turn after this date, the message will be shown. If date is nil, the message will be shown for all dates.)
      t.date :to_date,
             comment: %(When user tries to reserve for the associated reservation turn before this date, the message will be shown. If date is nil, the message will be shown for all dates. To set a message for exactly one date, set from_date and to_date to the same date.)

      t.timestamps
    end
  end
end
