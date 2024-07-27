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