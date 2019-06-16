class Review < ApplicationRecord
	validates :body, length: { maximum: 200 }

	belongs_to :user
	belongs_to :product
end
