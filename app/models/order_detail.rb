class OrderDetail < ApplicationRecord

	belongs_to :order
	has_many :products
end
