# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)





# 管理者シード
admin = Admin.new(:email => 'hogehoge@hoge.com', :password => 'hugahuga')
admin.save!


# ユーザーシード
30.times do
	Faker::Config.locale = :ja
	kanji_firstname = Faker::Name.first_name
	kanji_lastname = Faker::Name.last_name
	kana_firstname = Faker::Name.first_name
	# kana_lastname = Faker::Name.last_name
	user_name = Faker::Games::Pokemon.name
	email = Faker::Internet.email
	postal_address = Faker::Address.full_address
	random = Random.new()

	User.create!(kanji_firstname: kanji_firstname,
				 kanji_lastname: kanji_lastname,
				 kana_firstname: kana_firstname,
				 kana_lastname: "サノ",
				 user_name: user_name,
				 email: email,
				 phone_number: random.rand(10000000000..99999999999),
				 postal_code: random.rand(1000000..9999999),
				 postal_address: postal_address,
				 password: random.rand(1000000..9999999)
				 )
end


# ジャンルシード

Genre.create!(genre: "JPOP")
Genre.create!(genre: "洋楽")
Genre.create!(genre: "KPOP")
Genre.create!(genre: "ロック/オルタナティブ")
Genre.create!(genre: "パンク/ハードコア")
Genre.create!(genre: "ビジュアル")
Genre.create!(genre: "R&B/ソウル")
Genre.create!(genre: "ヒップホップ")
Genre.create!(genre: "レゲエ/スカ")

# アーティスト名シード
5.times do
	name = Faker::Music::RockBand.name
	Artist.create!(name: name)
end

# レーベルシード
5.times do
	label = Faker::Creature::Dog.breed
	Label.create!(label: label)
end


# 商品シード
80.times do
	product_name  = Faker::Music.unique.album
	product_name  = Faker::Music.instrument
	description = Faker::Quote.famous_last_words


Product.create!(genre_id: rand(1..5),
				artist_id: rand(1..5),
				label_id: rand(1..5),
				product_name: product_name,
				price: rand(1000..50000),
				description: description,
				stock: rand(0..500),
				recommend: Faker::Boolean.boolean(0.1))
end

# ディスクシード
160.times do |time|
	random = Random.new()
	Disk.create!(product_id: random.rand(1..80),
				number: time + 1)
end

# 収録曲シード
320.times do
	random = Random.new()
	name = Faker::Music::UmphreysMcgee.song
	number = Faker::Number.decimal(2)
	Song.create!(disk_id: random.rand(1..160),
				song: name,
				second: number)
end

