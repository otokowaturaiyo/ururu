class Disk < ApplicationRecord
	belongs_to :product
	has_many :songs, dependent: :destroy
	accepts_nested_attributes_for :songs, allow_destroy: true

	# validates :product_id, presence: true
end
