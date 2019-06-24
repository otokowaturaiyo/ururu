class Order < ApplicationRecord


	belongs_to :user
	has_many :products
	has_many :order_details, dependent: :destroy
end
