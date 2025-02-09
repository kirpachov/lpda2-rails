# frozen_string_literal: true

class CreateReservationTurnToMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_turn_to_messages do |t|
      t.references :reservation_turn, null: false, foreign_key: true,
                                      index: { name: "turn_id_reservation_turn_to_messages" }
      t.references :reservation_turn_message, null: false, foreign_key: true,
                                              index: { name: "message_id_reservation_turn_to_messages" }

      t.timestamps
    end
  end
end
