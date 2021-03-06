class Product < ApplicationRecord
  belongs_to :genre
  belongs_to :artist
  belongs_to :label
  has_many :cart_items
  has_many :disks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_details

  accepts_nested_attributes_for :disks, allow_destroy: true

  validates :product_name, presence: true
  validates :genre_id, presence: true
  validates :artist_id, presence: true
  validates :label_id, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :stock, presence: true , format: { with: /\A[0-9]+\z/ }
  validates :recommend, inclusion: { in: [true, false] }

  attachment :jacket_image

  # ユーザーがレビューをすでに投稿していたら、それ以上の投稿を制限する
  def reviewed_by?(user)
    reviews.where(user_id: user.id).exists?
  end

  # 検索で入力された情報をモデルに探してもらう
  def self.search(search)
    if search
      Product.where(['product_name LIKE ?', "%#{search}%"])
    else
      Product.all
    end
  end

  def likes?(user)
    ret = false
    if user.present?
      ret = likes.where(user_id: user.id).exists?
    end
    return ret
  end
end
