def debug(message)
  Rails.logger.debug { message }
  puts message
end

debug "Creating missing images..."
CreateMissingImages.run!

LPDA2_ALLOW_PRODUCTION_SEEDS = ENV["LPDA2_ALLOW_PRODUCTION_SEEDS"] == "true"

if Rails.env.production? && !LPDA2_ALLOW_PRODUCTION_SEEDS
  debug "You're in production. Exiting. To run seeds in production, set LPDA2_ALLOW_PRODUCTION_SEEDS=true"
  exit
end

debug "Importing images..."
Dev::ImportImages.run!

debug "Importing ingredients..."
Dev::Menu::ImportIngredients.run!

debug "Importing tags..."
Dev::Menu::ImportTags.run!

debug "Importing allergens..."
Dev::Menu::ImportAllergens.run!

debug "Creating default settings..."
Setting.create_missing

debug "Importing menus..."
Dev::Menu::ImportMenus.run!

debug "Importing categories..."
Dev::Menu::ImportCategories.run!

debug "Importing dishes..."
Dev::Menu::ImportDishes.run!

ReservationTurn.delete_all

debug "Creating reservation turns..."
(0..6).each do |weekday|
  ReservationTurn.create!(name: "Pranzo", weekday:, starts_at: "12:00", ends_at: "14:00")
  ReservationTurn.create!(name: "Cena 1", weekday:, starts_at: "18:00", ends_at: "19:59")
  ReservationTurn.create!(name: "Cena 2", weekday:, starts_at: "20:00", ends_at: "21:30")
end

Reservation.delete_all

[
  {
    fullname: "Sasha",
    datetime: Time.zone.now.iso8601,
    status: "active",
    secret: "DEletEd",
    adults: 2,
    table: nil,
    notes: nil,
    email: "sasha@opinioni.net",
    phone: nil
  }
].each do |reservation_data|
  Rails.logger.debug { "Creating reservation: #{reservation_data}" }
  Reservation.create! reservation_data
end

User.create!(email: "sasha@opinioni.net", password: "admin")

PublicMessage::KNOWN_KEYS.each do |key|
  PublicMessage.find_or_create_by!(key:)
end

%w[monday tuesday wednesday thursday friday saturday sunday].each do |weekday|
  m = PublicMessage.find_or_create_by!(key: "openings_#{weekday}")
  m.assign_translation("text", { it: "12-22", en: "12-22" })
  m.save!
end
