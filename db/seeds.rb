# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.production?
  puts "You're in production mode. You should not seed the database."
  exit
end

# image = Image.create!(filename: 'cat.jpeg')
# image.attached_image.attach(io:  File.open(Rails.root.join('spec', 'fixtures', 'files', 'cat.jpeg')), filename: 'cat.jpeg')
# GenerateImageVariants.run!(image: image)

ReservationTurn.delete_all

ReservationTurn.create!(name: 'Pranzo', weekday: 0, starts_at: '13:00', ends_at: '15:00')
ReservationTurn.create!(name: 'Cena 1', weekday: 0, starts_at: '19:00', ends_at: '20:59')
ReservationTurn.create!(name: 'Cena 2', weekday: 0, starts_at: '21:00', ends_at: '22:00')