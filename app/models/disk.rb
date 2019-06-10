class Disk < ApplicationRecord
	belongs_to :product
	has_many :songs

	validates :product_id, presence: true
end
