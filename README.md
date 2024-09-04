# La Porta d'Acqua v2 - Rails

[![Ruby on Rails CI](https://github.com/kirpachov/lpda2-rails/actions/workflows/parallel-rspec.yml/badge.svg?branch=develop)](https://github.com/kirpachov/lpda2-rails/actions/workflows/parallel-rspec.yml)

Backend in Ruby On Rails per la seconda versione del sito laportadacqua.com.

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
Per far partire `rails s` dentro docker:
```
docker compose up --build
```

Rails risponde alla porta 3050.

In generale, rispetto al "solito" sviluppo, dove per intenderci per far partire rails server basta fare `rails s`, in questo caso bisogna anteporre `docker compose run <nome-servizio>` al comando da eseguire.
In questo caso il nostro servizio si chiama "rails" (vedi (docker-compose.yml)[./docker-compose.yml]), quindi per accedere alla console basterà eseguire `docker compose run rails rails c`. Se si volessero includere variabili d'ambiente, lo si può fare con il parametro `--env` da mettere prima del nome del servizio.

- Collegarsi a `rails console`: `docker compose run rails rails c`
- Far girare rspec: `docker compose run --env RAILS_ENV=test rails rails db:drop db:create db:migrate spec`
- Far girare parallel spec: `docker compose run --env RAILS_ENV=test rails rake parallel:drop parallel:create parallel:migrate parallel:spec`
- Collegarsi al database: In base alle configurazioni presenti in docker-compose.yml, se la porta è condivisa ci si può collegare direttamente con `PGPASSWORD="somethingNooneWillGuess" psql -h localhost -p 5430 -U postgres`, alternativamente ci si collega passando per il servizio rails, in questo modo:`docker compose run rails bash -c "PGPASSWORD=somethingNooneWillGuess psql -U postgres -h postgres"`

## Docker cleanup
```
docker container rm $(docker container ls --all | awk '{print $1}') -f
docker image rm $(docker image ls --all | awk '{print $3}')
docker volume rm $(docker volume ls | awk '{print $2}')
docker compose up -d
```