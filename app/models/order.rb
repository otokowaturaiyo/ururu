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

  before_validation :set_price
  after_save :delete_stocks
  before_save :set_shipment_status

  def set_price
    self.order_details.each do |o|
      o.price = o.product.price
    end
  end

  def set_shipment_status
    if self.payment_methods == "クレジットカード" || self.payment_methods == "代引き"
      self.shipment_status = "発送準備中"
    elsif self.payment_methods == "銀行振込"
      self.shipment_status = "入金待ち"
    end
  end

  def delete_stocks
    # 在庫削除
    self.order_details.each do |o|
      product = Product.find(o.product_id)
      updated_stock = product.stock - o.product_count
      product.update_attributes(stock: updated_stock)
    end
  end
end
