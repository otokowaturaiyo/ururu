require 'payjp'

class Order < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details

  validates :payment_methods, presence: true
  validates :destination, presence: true
  validates :destination_name, presence: true
  validates :destination_postal_code, presence: true
  validates :destination_phone_number, presence: true

  after_save :create_order

  def create_order
    # 在庫削除
    self.order_details.each do |o|
      product = Product.find(o.product_id)
      updated_stock = product.stock - o.product_count
      product.update_attributes(stock: updated_stock)
    end
  end
end
