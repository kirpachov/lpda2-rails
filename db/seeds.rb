puts "Creating missing images..."
CreateMissingImages.run!

if Rails.env.production?
  puts "You're in production mode. Exiting..."
  exit
end

ReservationTurn.delete_all

puts "Creating reservation turns..."
(0..6).each do |weekday|
  ReservationTurn.create!(name: 'Pranzo', weekday:, starts_at: '13:00', ends_at: '15:00')
  ReservationTurn.create!(name: 'Cena 1', weekday:, starts_at: '19:00', ends_at: '20:59')
  ReservationTurn.create!(name: 'Cena 2', weekday:, starts_at: '21:00', ends_at: '22:00')
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

