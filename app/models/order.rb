class Order < ApplicationRecord


	belogs_to :user
	has_many :products
end
