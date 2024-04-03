Rails.logger.debug "Creating missing images..."
CreateMissingImages.run!

if Rails.env.production?
  Rails.logger.debug "You're in production. Exiting..."
  exit
end

Rails.logger.debug "Importing ingredients..."
Dev::Menu::ImportIngredients.run!

Rails.logger.debug "Importing tags..."
Dev::Menu::ImportTags.run!

Rails.logger.debug "Importing allergens..."
Dev::Menu::ImportAllergens.run!

ReservationTurn.delete_all

Rails.logger.debug "Creating reservation turns..."
(0..6).each do |weekday|
  ReservationTurn.create!(name: "Pranzo", weekday:, starts_at: "12:00", ends_at: "14:00")
  ReservationTurn.create!(name: "Cena 1", weekday:, starts_at: "18:00", ends_at: "19:59")
  ReservationTurn.create!(name: "Cena 2", weekday:, starts_at: "20:00", ends_at: "21:30")
end

Reservation.delete_all

[
  {
    fullname: "Sasha",
    datetime: "2024-02-17T21:51:06.145Z",
    status: "active",
    secret: "DEletEd",
    people: 2,
    table: nil,
    notes: nil,
    email: "sasha@opinioni.net",
    phone: nil
  }
].each do |reservation_data|
  Rails.logger.debug { "Creating reservation: #{reservation_data}" }
  Reservation.create! reservation_data
end

User.create!(email: "sasha@opinioni.net")
