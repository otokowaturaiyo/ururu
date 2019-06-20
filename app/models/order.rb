require 'payjp'

class Order < ApplicationRecord
	belongs_to :user
	has_many :products
	has_many :order_details
	accepts_nested_attributes_for :order_details

	# validates :paymethods, presence: true
end
