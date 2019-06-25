FactoryGirl.define do
  factory :user do
    kanji_firstname: kanji_firstname,
                 kanji_lastname: kanji_lastname,
                 kana_firstname: 'コウイチ',
                 kana_lastname: 'サノ',
                 user_name: user_name,
                 email: email,
                 phone_number: random.rand(10000000000..99999999999),
                 postal_code: random.rand(1000000..9999999),
                 postal_address: postal_address,
                 password: random.rand(1000000..9999999))
  end
end
