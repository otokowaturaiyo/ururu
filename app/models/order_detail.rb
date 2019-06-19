class OrderDetail < ApplicationRecord

	belongs_to :order
	# belongs_to :order ,  option:true
	# has_many :products
end
