# frozen_string_literal: true

# When a reservation is created and a payment is required,
# will eneueue this job 15 minutes later:
# if the user has completed the reservation and reservation email hasnt sill been sent,
# it will send the first confirmation email.
# otherwise, will deliver "payment required" email.
class DeliverFirstConfirmationEmail < ActiveInteraction::Base
  record :reservation

  delegate :confirmation_email_delivered?, :confirmed?, :delivered_emails, to: :reservation

  validates :reservation, presence: true

  def execute
    return skip_reason if can_skip?

    return reservation.deliver_confirmation_email if confirmed?

    reservation.deliver_payment_required_email
  end

  def can_skip?
    skip_reason.present?
  end

  def skip_reason
    return "email already delivered" if delivered_emails.count.positive?
    return "reservation status <> active: #{reservation.status}" unless reservation.active?
    unless Reservation.public_visible.next.exists?(id: reservation.id)
      return "reservation could not be found between visible and next reservations"
    end

    nil
  end
end
