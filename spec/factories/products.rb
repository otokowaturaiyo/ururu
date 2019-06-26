FactoryBot.define do
  factory :product, class: Product do
    genre_id {1}
    artist_id {1}
    label_id {1}
    product_name {"hoge"}
    price {1000}
    description {"hogeeeeeeeeeeeeeeeee"}
    stock {25}
    recommend {true}
    artist
    genre
    label
  end

  factory :artist, class: Artist do
    name {"BUNP OF CHICKEN"}
  end

  factory :genre, class: Genre do
    genre {"JPOP"}
  end

  factory :label, class: Label do
    label {"Toys Factory"}
  end
end
