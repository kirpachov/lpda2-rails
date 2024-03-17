puts "Creating missing images..."
CreateMissingImages.run!

if Rails.env.production?
  puts "You're in production. Exiting..."
  exit
end

ReservationTurn.delete_all

puts "Creating reservation turns..."
(0..6).each do |weekday|
  ReservationTurn.create!(name: 'Pranzo', weekday:, starts_at: '12:00', ends_at: '14:00')
  ReservationTurn.create!(name: 'Cena 1', weekday:, starts_at: '18:00', ends_at: '19:59')
  ReservationTurn.create!(name: 'Cena 2', weekday:, starts_at: '20:00', ends_at: '21:30')
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
  puts "Creating reservation: #{reservation_data}"
  Reservation.create! reservation_data
end

User.create!(email: "sasha@opinioni.net")


