# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
	name = Faker::Music::RockBand.name
	Artist.create!(name: name)
end

5.times do
	genre = Faker::Music.genre
	Genre.create!(genre: genre)
end

5.times do
	label = Faker::Creature::Dog.breed
	Label.create!(label: label)
end


80.times do
	product_name  = Faker::Music.unique.album
	description = Faker::Quote.famous_last_words
	random = Random.new()
	
  	Product.create!(genre_id: random.rand(1..5),
  					artist_id: random.rand(1..5),
  					label_id: random.rand(1..5),
  					product_name: product_name,
  					price: random.rand(1000..50000),
  					description: description,
  					stock: random.rand(0..500),
  					recommend: Faker::Boolean.boolean(0.1))
end


