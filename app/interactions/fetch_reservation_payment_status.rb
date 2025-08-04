# frozen_string_literal: true

# Will fetch status of the payment from each provider for a ReservationPayment.
class FetchReservationPaymentStatus < ActiveInteraction::Base
  record :reservation_payment, class: ReservationPayment

  set_callback :execute, :before, -> { reservation_payment.reload }

  validate do
    errors.add(:reservation_payment, "does not have an 'external_id'") unless reservation_payment.external_id.present?
  end

  validates :reservation_payment, presence: true

  attr_reader :call

  def execute
    case reservation_payment.preorder_type
    when "html_nexi_payment", "html_nexi_authorization" then fetch_nexi_status
    when "stripe_authorization", "stripe_payment" then fetch_stripe_checkout_status
    else
      errors.add(:reservation, "payment type #{reservation_payment.preorder_type.inspect} not supported")
    end
  end

  def fetch_stripe_checkout_status
    @call = Stripe::FetchReservationPaymentStatus.run(
      reservation_payment:
    )

    errors.merge!(call.errors) if call.errors.any? || call.invalid?

    call.result
  end

  def fetch_nexi_status
    @call = Nexi::GetOrderStatus.run(
      order_id: reservation_payment.external_id,
      request_record: reservation_payment
    )

    return errors.merge!(call.errors) unless call.valid?

    # In case user did not proceed with the payment, nexi won't find the order
    # In this case, NEXI will respond with something like this:
    # {
    #   "esito" => "KO",
    #   "idOperazione" => "1556929671",
    #   "timeStamp" => "1732363212583",
    #   "mac" => "221068eab6c869d4cf8a77181d2219fce8161dc0",
    #   "errore" => { "codice" => 2, "messaggio" => "Nessun ordine trovato" }
    # }
    return if reservation_payment.todo? && call.result["esito"].to_s.downcase == "ko" && call.result.dig("errore",
                                                                                                         "codice").to_s == "2"

    item = call.result["report"]&.find { |i| i["codiceTransazione"] == reservation_payment.external_id }
    unless item.present?
      return errors.add(:reservation_payment,
                        "item not found inside report field. #{call.result.inspect}")
    end

    unless item["stato"].present?
      return errors.add(:reservation_payment,
                        "item does not have a 'stato' field. #{item.inspect}")
    end

    # https://ecommerce.nexi.it/specifiche-tecniche/apibackoffice/interrogazionedettaglioordine.html
    # Stati possibili:
    # Non Creato: il pagamento non è arrivato all’autorizzazione, si è verificato un problema sulle fasi precedenti (es.: interruzione del 3dSecure da parte dell’utente).
    # Autorizzato: il pagamento è stato autorizzato, non ancora contabilizzato. La contabilizzazione avviene di default automaticamente da parte di NEXI, alle ore 24 dello stesso giorno
    # Negato: il pagamento non è stato autorizzato. Non verrà quindi contabilizzato.
    # Annullato: il pagamento è stato autorizzato ma poi annullato, o per errore di notifica, o su esplicita azione dell’esercente (tramite back office, o tramite API).
    # Contabilizzato: il pagamento è stato contabilizzato.
    # Contabilizzato Parz.: sul pagamento è stato effettuato un incasso parziale dell’importo autorizzato.
    # Rimborsato: il pagamento, in precedenza contabilizzato, è stato completamente rimborsato all’utente.
    # Rimborsato Parz.: sul pagamento è stato effettuato un rimborso parziale dell’importo contabilizzato.
    # In Corso: la transazione è in corso di esecuzione.

    case item["stato"]
    when "Annullato", "Rimborsato", "Rimborsato Parz."
      reservation_payment.refunded!
    when "Contabilizzato", "Contabilizzato Parz.", "Autorizzato"
      if reservation_payment.deferred?
        # If authorization already charged, don't set to 'authorized' again.
        reservation_payment.authorized! unless reservation_payment.paid?
      else
        reservation_payment.paid!
      end
    when "Negato"
      reservation_payment.todo!
    end
  end
end
