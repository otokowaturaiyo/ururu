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


20.times do
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

40.times do |time|
	random = Random.new()
	Disk.create!(product_id: random.rand(1..20),
				number: time + 1
		)
end

80.times do
	random = Random.new()
	name = Faker::Music::UmphreysMcgee.song
	number = Faker::Number.decimal(2)
	Song.create!(disk_id: random.rand(1..40),
				song: name,
				second: number
		)
end


30.times do
	Faker::Config.locale = :ja
	kanji_firstname = Faker::Name.first_name
	kanji_lastname = Faker::Name.last_name
	kana_firstname = Faker::Name.first_name
	kana_lastname = Faker::Name.last_name
	user_name = Faker::Games::Pokemon.name
	email = Faker::Internet.email
	postal_address = Faker::Address.full_address
	random = Random.new()

	User.create!(kanji_firstname: kanji_firstname,
				 kanji_lastname: kanji_lastname,
				 kana_firstname: kana_firstname,
				 kana_lastname: kana_lastname,
				 user_name: user_name,
				 email: email,
				 phone_number: random.rand(10000000000..99999999999),
				 postal_code: random.rand(1000000..9999999),
				 postal_address: postal_address,
				 password: random.rand(1000000..9999999)
				 )
end



