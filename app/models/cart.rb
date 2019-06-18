class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :product_count, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :product_price, presence: true, numericality: {greater_than_or_equal_to: 1}
end
