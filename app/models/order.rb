require 'payjp'

class Order < ApplicationRecord
	belongs_to :user
	has_many :order_details, dependent: :destroy
	accepts_nested_attributes_for :order_details

	validates :paymethods, presence: true
	validates :destination, presence: true
	validates :destination_name, presence: true
	validates :destination_postal_code, presence: true
	validates :destination_phone_number, presence: true
end
