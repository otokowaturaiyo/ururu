class Product < ApplicationRecord
	belongs_to :genre
	belongs_to :artist
	belongs_to :label
	has_many :disks, dependent: :destroy
	accepts_nested_attributes_for :disks, allow_destroy: true

	

	attachment :jacket_image

	def find_product
      @product = Product.find(params[:id])
      @artist = Artist.find(@product.artist_id)
      @genre = Genre.find(@product.genre_id)
      @label = Label.find(@product.label_id)
    end

	#検索で入力された情報をモデルに探してもらう
	def self.search(search)
      if search
        Product.where(['product_name LIKE ?', "%#{search}%"])
      else
        Product.all
      end
    end
end
