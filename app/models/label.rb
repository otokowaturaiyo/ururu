class Label < ApplicationRecord
	has_many :products, dependent: :destroy

	validates :label, presence: true
end
