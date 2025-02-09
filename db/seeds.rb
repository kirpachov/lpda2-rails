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

Menu::Dish.all.update(status: :active)

ReservationTurn.delete_all

debug "Creating reservation turns..."
(0..6).each do |weekday|
  ReservationTurn.create!(name: "Pranzo (#{ReservationTurn::WEEKDAYS[weekday]})", weekday:, starts_at: "10:00",
                          ends_at: "12:00")
  ReservationTurn.create!(name: "Cena 1 (#{ReservationTurn::WEEKDAYS[weekday]})", weekday:, starts_at: "16:00",
                          ends_at: "17:59")
  ReservationTurn.create!(name: "Cena 2 (#{ReservationTurn::WEEKDAYS[weekday]})", weekday:, starts_at: "18:00",
                          ends_at: "19:30")
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

User.create!(email: "sasha@opinioni.net", password: "admin!", username: "sasha")

PublicMessage::KNOWN_KEYS.each do |key|
  PublicMessage.find_or_create_by!(key:)
end

%w[monday tuesday wednesday thursday friday saturday sunday].each do |weekday|
  m = PublicMessage.find_or_create_by!(key: "openings_#{weekday}")
  m.assign_translation("text", { it: "12-22", en: "12-22" })
  m.save!
end

debug "Creating default preorder group..."

preorder_group = PreorderReservationGroup.create!(
  title: "Default preorder",
  payment_value: 15.2
)

2.times do
  weekday = (0..6).to_a.sample

  preorder_group.dates.create!(
    date: Date.current.next_occurring(ReservationTurn::WEEKDAYS[weekday].to_sym),
    reservation_turn: ReservationTurn.where(weekday:).sample
  )
end

free_turns = ReservationTurn.where.not(id: preorder_group.dates.pluck(:reservation_turn_id))

preorder_group.turns = free_turns.sample(2)

(-10..10).to_a.each do |day_ago|
  5.times do
    Reservation.create!(adults: [2, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10].sample, fullname: Faker::Name.first_name,
                        email: "sasha+#{SecureRandom.hex}@opinioni.net", datetime: day_ago.days.ago.beginning_of_day + [10, 11, 12, 18, 19, 20].sample.hours)
  end
end
