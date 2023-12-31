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

image = Image.create!(filename: 'cat.jpeg')
image.attached_image.attach(io:  File.open(Rails.root.join('spec', 'fixtures', 'files', 'cat.jpeg')), filename: 'cat.jpeg')
GenerateImageVariants.run!(image: image)