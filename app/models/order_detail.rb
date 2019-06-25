class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :product_count, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
