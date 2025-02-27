# frozen_string_literal: true

module Nexi
  class SimplePayment < ActiveInteraction::Base
    float :amount
    string :language
    string :result_url
    string :cancel_url

    # When true, the payment is not executed immediately.
    # Restaurant will have to manually confirm the payment, in case people don't show up.
    boolean :deferred

    # Why this order is being made?
    string :request_purpose
    interface :request_record, methods: %w[id persisted? update], default: nil # Object to associate to http request

    interface :additional_params, methods: %w[each keys merge], default: {}

    attr_reader :client

    def execute
      @client = Client.run(
        params:,
        path: Config.nexi_simple_payment_path,
        request_purpose:,
        request_record:,
        mac_part: "codTrans=#{params.dig!(:codTrans)}divisa=#{params.dig!(:divisa)}importo=#{params.dig!(:importo)}"
      )

      errors.merge!(@client.errors)

      validate_response if errors.empty?

      return false if errors.any? || invalid?

      client.json
    end

    def cod_trans
      @cod_trans ||= "PS#{Time.zone.now.strftime("%Y%m%d%H%M%S")}"
    end

    def params
      @params ||= (additional_params || {}).merge(
        importo: (amount * 100).to_i.to_s,
        divisa: "EUR", # The only supported rn
        codTrans: cod_trans,
        url: result_url,
        url_back: cancel_url,
        languageId: language,

        # https://ecommerce.nexi.it/specifiche-tecniche/codicebase.html
        # Il campo identifica la modalità di incasso che l'esercente vuole applicare alla singola transazione, se valorizzato con:
        # - C (immediata) la transazione se autorizzata viene anche incassata senza altri interventi da parte dell'esercente e senza considerare il profilo di default impostato sul terminale.
        # - D (differita) o non viene inserito il campo, la transazione se autorizzata viene gestita secondo quanto definito dal profilo del terminale.
        # L'incasso immediato è quello stabilito come standard da Nexi. Se vuoi gestire incassi differiti richiedi al supporto tecnico l'abilitazione. Una volta abilitato, in caso di incasso differito la riscossione è in carico all'esercente che può gestirla da back office, tramite API o a scadenza automatica comunicata in fase di configurazione del profilo.
        TCONTAB: deferred ? "D" : "C"
      )
    end

    def validate_response
      e = []
      e << "is blank" if client.json.blank? && client.html.blank?
      e << "is not a hash" if e.empty? && !client.json.is_a?(Hash)

      errors.add(:client, "invalid response #{client.json.inspect}: #{e.join(", ")}") if e.any?
    end
  end
end
