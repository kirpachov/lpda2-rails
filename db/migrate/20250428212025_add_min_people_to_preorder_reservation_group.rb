# frozen_string_literal: true

class AddMinPeopleToPreorderReservationGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :preorder_reservation_groups, :min_people, :integer, comment: %(When creating a reservation and this value is set, payment will be required for reservations with more (>=) than this value people)
  end
end
