# La Porta d'Acqua v2 - Rails

[![Ruby on Rails CI](https://github.com/kirpachov/lpda2-rails/actions/workflows/parallel-rspec.yml/badge.svg?branch=develop)](https://github.com/kirpachov/lpda2-rails/actions/workflows/parallel-rspec.yml)

Backend in Ruby On Rails per la seconda versione del sito laportadacqua.com.

Frontend disponibile [qui](https://github.com/kirpachov/lpda2-angular)

## Domande:
- È obbligatoria la conferma via mail o messaggio per la creazione della prenotazione? Si potrebbe fare un sistema che non crea la prenotazione finché non si clicca sul link di conferma inviato via mail e messaggio.

## Prenotazioni
Lato pubblico tutti i campi saranno obbligatori:
- Email
- Cellulare
- Nome e cognome
- Data e ora prenotazione (che dev'essere compatibile con un turno di prenotazioni e non ci devono essere ferie nel mezzo)

Lato amministrativo è possibile creare prenotazioni a qualsiasi ora, ma si ottengono comunque dei warning per le cose sopra citate.

Non è necessario chiedere le generalità di tutti i clienti ma di uno solo e la quantità di clienti.

Niente no-show automatico.

## Visibilità menu (categorie)
È necessario che in una categoria o che in tutti i suoi piatti ci sia un prezzo non nullo (prezzo 0 va bene!).

Si può pubblicare una categoria:
- tutti i piatti e tutte le categorie devono avere almeno un immagine
- i piatti possono anche non avere ingredienti ma bisogna avvertire l'utente
- Tutti i piatti e le categorie devono avere un nome.
- Se ci sono descrizioni nulle bisogna avvertire l'utente.

Deve essere possibile poter mostrare e nascondere le categorie in determinate fasce orarie:
per ora di pranzo il menù cena si nasconde; per cena il menù pranzo si nasconde.

## Feature
- Possibilità di aggiungere ad un determinato piatto un pairing o consiglio con un vino o un cocktail

## Note sviluppo
Il backend ragiona sempre in UTC. Sarà il frontend a convertire le date.

## Docker

### First setup
Before anything else, you need to define `docker-compose.override.yml`. If you don't define it, `docker compose` will fail.
To define it, either copy `docker-compose.dev.yml` or `docker-compose.prod.yml`, depending on your need.

> Docker Compose version v2.29.2

> Docker version 27.2.0, build 3ab4256

Prima installazione: inizializzazione database. 
```bash
docker compose run rails bundle exec rake db:create db:migrate db:seed
```

Per far partire `rails s` dentro docker:
```bash
docker compose up --build --remove-orphans -d
```

Seed: `docker compose run rails rails db:seed`

Rspec: `docker compose run --env RAILS_ENV=test rails rspec`

Parallel spec: `RAILS_ENV=test docker compose run rails bundle exec rake parallel:drop parallel:create parallel:migrate parallel:spec`

Rails risponde alla porta 3050.

In generale, rispetto al "solito" sviluppo, dove per intenderci per far partire rails server basta fare `rails s`, in questo caso bisogna anteporre `docker compose run <nome-servizio>` al comando da eseguire.
In questo caso il nostro servizio si chiama "rails" (vedi docker-compose.yml), quindi per accedere alla console basterà eseguire `docker compose run rails rails c`. Se si volessero includere variabili d'ambiente, lo si può fare con il parametro `--env` da mettere prima del nome del servizio.

- Collegarsi a `rails console`: `docker compose run rails rails c`
- Far girare rspec: `docker compose run --env RAILS_ENV=test rails rails db:drop db:create db:migrate spec`
- Far girare parallel spec: `docker compose run --env RAILS_ENV=test rails rake parallel:drop parallel:create parallel:migrate parallel:spec`
- Collegarsi al database: In base alle configurazioni presenti in docker-compose.yml, se la porta è condivisa ci si può collegare direttamente con `PGPASSWORD="somethingNooneWillGuess" psql -h localhost -p 5430 -U root`, alternativamente ci si collega passando per il servizio rails, in questo modo:`docker compose run rails bash -c "PGPASSWORD=somethingNooneWillGuess psql -U root -h postgres"`


## Docker run production
Build image will be pulled from registry instead of locally build in production mode.

> Note: to avoid specifying "-f docker-compose.yml -f docker-compose.prod.yml", copy "docker-compose.prod.yml" into "docker-compose.override.yml" in the root directory.

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --remove-orphans

# Watch services going online:
watch docker ps

# Create production database:
docker compose -f docker-compose.yml -f docker-compose.prod.yml run rails rails db:create

# Migrate production database:
docker compose -f docker-compose.yml -f docker-compose.prod.yml run rails rails db:migrate

# Seed production database:
docker compose -f docker-compose.yml -f docker-compose.prod.yml run --env LPDA2_ALLOW_PRODUCTION_SEEDS=true rails rails db:seed
```

## Docker cleanup
```
docker container rm $(docker container ls --all | grep lpda | awk '{print $1}') -f
docker image rm $(docker image ls --all | grep lpda | awk '{print $3}') -f
# docker volume rm $(docker volume ls | grep lpda | awk '{print $2}') # CAREFUL: YOU WILL LOOSE YOUR POSTGRES DATABASE AND REDIS QUEUE.
docker compose up -d
```

## PITR
You'll need s3 configurations to use postgresql docker image.
Create them and add them to `.env` file.
All walfiles will be pushed as required.

### Push base backups
```bash
docker compose run postgres /push_base_backup.sh
```

## Docker status
Per cercare di capire cosa sta succedendo dentro docker:
`watch --interval 0.5 docker ps` Mostrerà i container che stanno girando ed il loro `healthchecks`

`watch --interval 0.5 docker compose top` Mostrerà i processi per ciascun container.

## Building and pushing docker images
It's important that the production server doesen't have to build the gems, since it can take long.

```bash
# script/build-docker.sh
docker build . -t lpda2-rails:latest
docker tag lpda2-rails:latest kirpachov/lpda2-rails:latest
docker push kirpachov/lpda2-rails:latest
```

## CORS configuration for production
Since frontend and backend will be hosted on different domains, we need to configure correclty CORS policies.

1. In the cookies, include ` { secure: true, same_site: "None" } `, like so:
```ruby
cookies.encrypted[:refresh_token] = {
  value: refresh_token.secret,
  httponly: true,
  expires: 1.week.from_now.utc
  expires: 1.week.from_now.utc,
  same_site: Config.all[:cookie_same_site], # !!
  secure: Config.all[:cookie_secure] # !!
}
```
2. Configure CORS gem to allow only the permitted origins:
```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # WARNING: Origins "*" IS NOT ALLOWED!!!
    origins "localhost", "your-production-domain.com"

    resource "*",
             headers: :any,
             methods: %i[get post put patch delete options head]
             methods: :any,
             credentials: true
  end
end
```

And... done! The rest of the work should be done on the [frontend site](https://github.com/kirpachov/lpda2-angular)