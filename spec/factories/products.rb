FactoryBot.define do
  factory :product do
    genre_id {1}
    artist_id {1}
    label_id {1}
    product_name {"hoge"}
    price {1000}
    description {"hogeeeeeeeeeeeeeeeee"}
    stock {25}
    recommend {true}
  end
end
