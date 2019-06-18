class Product < ApplicationRecord
	belongs_to :genre
	belongs_to :artist
	belongs_to :label
	has_many :carts
	has_many :disks, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :reviews, dependent: :destroy

	accepts_nested_attributes_for :disks, allow_destroy: true

	validates :product_name, presence: true, uniqueness: true
	validates :genre_id, presence: true
	validates :artist_id, presence: true
	validates :label_id, presence: true
	validates :price, presence: true
	validates :description, presence: true
	validates :stock, presence: true
	validates :recommend, inclusion: {in: [true, false]}

	attachment :jacket_image

	#検索で入力された情報をモデルに探してもらう
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
