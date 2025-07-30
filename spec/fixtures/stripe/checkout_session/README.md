# create_setup_success.json
```bash
curl --request POST \
  --url https://api.stripe.com/v1/checkout/sessions \
  --header 'Authorization: Basic c2tfdGVzdF85VzFSNHYwY3o2QXRDOVBWd0hGenl3dGk6' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --header 'Stripe-Version: 2025-05-28.basil' \
  --data mode=setup \
  --data success_url=https://q.opinioni.net \
  --data currency=EUR \
  --data mode=setup \
  --data ui_mode=hosted \
  --data =
```
