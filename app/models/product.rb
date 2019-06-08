class Product < ApplicationRecord
	belongs_to :genre
	belongs_to :artist
	belongs_to :label
	has_many :disks, dependent: :destroy

	validates :product_name, uniqueness: true

	attachment :jacket_image
end
