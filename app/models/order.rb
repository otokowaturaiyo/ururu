require 'payjp'

class Order < ApplicationRecord
	belongs_to :user
	has_many :products
	has_many :order_details
	accepts_nested_attributes_for :order_details




	#before_save :create_order
	def create_order(payjp_token)
		total_price = 0
		self.order_details.each do |od|
			product = Product.find(od.product_id)
			od.price = product.price

			#####　合計金額の計算（クレカ決済用）　<= ここモデルにまとめられそう　#####
			tax_included = od.price * 1.08
			subtotal_price = tax_included.to_i*od.product_count
			total_price += subtotal_price

			#####　在庫の削除　#####
			updated_stock = product.stock - od.product_count
			product.update_attributes(stock: updated_stock)
		end
		#####　クレジットカード決済処理　#####
		if self.payment_methods == "クレジットカード"
			#####　秘密鍵はベタうちせずに環境変数なるものを使った方がいいらしい。勉強予定。　#####
			Payjp.api_key = 'sk_test_421673bdeffac69c0df96e60'
			customer = Payjp::Customer.create(description: 'test')
			customer.cards.create(card: payjp_token)
			Payjp::Charge.create(
				amount:   total_price + 500,
				customer: customer.id,
				currency: 'jpy'
			)
		end
	end

end
