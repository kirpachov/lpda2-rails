# La Porta d'Acqua v2 - Rails

[![Ruby on Rails CI](https://github.com/kirpachov/lpda2-rails/actions/workflows/rubyonrails.yml/badge.svg?branch=develop)](https://github.com/kirpachov/lpda2-rails/actions/workflows/rubyonrails.yml)

Backend in Ruby On Rails per la seconda versione del sito laportadacqua.com.

## Domande

- Prenotazione: è necessario chiedere il nome di ciascun cliente, oppure è sufficiente dare un nome e indicare in quanti si è?
- Prenotazione: è obbligatorio il recapito telefonico? E l'email? Vale sia per il lato amministrativo che per il lato pubblico?
- Prenotazione: no-show automatico a fine serata se una prenotazione non è stata messa in stato "arrivato" ?

- La "visibilità" sarà possibile deciderla a livello di menù: un menù sarà visibile nella pagina pubblica o
  raggiungibile dal link segreto solo se impostato come tale. Tutte le sotto-categorie ed i piatti erediteranno quella
  visibilità.

- Pubblicazione: sarà possibile per motivi pratici avere piatti e categorie "invalidi", per esempio senza nome o
  immagine. Sarà però necessario risolvere alcuni problemi prima di poter pubblicare il menù. Questo serve a creare un
  meccanismo per cui l'utente non può pubblicare un menù con errori. Le condizioni necessarie per la pubblicazione sono:
  - Deve esserci un prezzo: al livello di categoria (es. menu a prezzo fisso), o tutti i piatti devono avere il prezzo (il prezzo può essere impostato a 0 per casi estremi, ma deve essere impostato per procedere con la pubblicazione).
  - Ogni piatto e la categoria devono avere almeno un immagine valida.
  - Si può pubblicare solo la categoria/menu principale, non le sotto-categorie. La visibilità viene gestita al livello di categoria principale.
  - Ogni piatto deve avere almeno un ingrediente (?)