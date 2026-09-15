# frozen_string_literal: true

class AddFeedbackTimestampsToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :fb_asked_at, :timestamp, comment: %(The moment the feedback was requested)
    add_column :reservations, :fb_open_at, :timestamp, comment: "The timestamp when the feedback URL was opened"
  end
end
