class Genre < ApplicationRecord
	has_many :products, dependent: :destroy

	validates :genre, presence: true
end
