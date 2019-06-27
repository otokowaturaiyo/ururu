FactoryBot.define do
  factory :user do
    kanji_firstname {"浩一"}
    kanji_lastname {"佐野"}
    kana_firstname {"コウイチ"}
    kana_lastname {"サノ"}
    user_name {"さのぴっぴ"}
    sequence(:email) {|n|"coca#{n}@cola.com"}
    phone_number {"08012345678"}
    postal_code {"1234567"}
    postal_address {"東京"}
    password {"password"}
  end
end


FactoryBot.define do
  factory :admins_user do
    sequence(:email) {|n|"hoge#{n}@hoge.com"}
    encrypted_password {"password"}
  end
end