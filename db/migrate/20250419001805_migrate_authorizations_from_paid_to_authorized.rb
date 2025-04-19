# frozen_string_literal: true

class MigrateAuthorizationsFromPaidToAuthorized < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        ReservationPayment.html_nexi_authorization.paid.find_each { |j| j.update(status: :authorized) }
      end

      dir.down do
        ReservationPayment.html_nexi_authorization.authorized.find_each do |j|
          j.update(status: :paid) if j.status == "authorized"
        end
      end
    end
  end
end
