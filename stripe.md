# Integrazione con STRIPE

- [APIs](https://docs.stripe.com/api)
- [DOCS](https://docs.stripe.com/payments)
- [Salvataggio metodo di pagamento per uso futuro](https://docs.stripe.com/payments/save-and-reuse)
- [Checkout session](https://docs.stripe.com/api/checkout/sessions/create)

## Funzionalità nell'integrazione con STRIPE

- Funzionalità di rimborso
- Rimborso automatico nel caso in cui vi sia stato fatto un pagamento e l'utente cancelli la prenotazione in tempo
- testa Stripe::CreateCheckoutSession nel caso in cui si verifichino Stripe::StripeErrore StandardError dentro do_call
- testa FetchReservationPaymentStatusJob, UpdateAllReservationPaymentStatusJob
- ricezione in tempo reale degli eventi con webhook

## Fatto (forse)
- Pagamento diretto (e.g. per pagamento per tavolo speciale)
- Pagamento con metodo precedentemente autorizzato (e.g. cliente non si presenta ma aveva autorizzato il pagamento)
- Download dello stato del pagamento
- Autenticazione STRIPE
- Pre-autorizzazione senza alcun addebito (e.g. per creazione prenotazioni)
- Gestione della duale integrazione tra STRIPE e NEXI, nel caso STRIPE dovesse dare problemi sarà possibile tornare ad utilizzare NEXI.
- Test lato backend della verifica delle funzionalità. Questa parte è la più importante in quanto ogni possibile situazione deve essere prevista, simulata in un ambiente controllato e gestita al meglio.

## Da verificare
- Cosa succede se due customer hanno la stessa email / fullname ?
- hpp_url passato al client dovrebbe essere in ogni caso il backend, in modo da tracciare gli eventi di apertura.
- aggiornamento immediato dello stato degli ordini stripe: webhook?

## Local event testing
```bash
stripe login
stripe listen --forward-to localhost:3050/v1/stripe/receive_event
stripe trigger payment_intent.succeeded
```
