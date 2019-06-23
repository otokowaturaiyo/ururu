class OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :setup_order!, only: [:confirm, :destination_update]
	before_action :setup_destination!, only: [:confirm]

	def confirm
		@order = Order.new
  end

	def destination_update
		@order = Order.new(order_params)
		render action: "confirm"
	end

	def create
		##### 注文を作成　#####
		order = Order.new(order_params)
		order.user_id = current_user.id
		total_price = 0
		order.order_details.each do |od|
			product = Product.find(od.product_id)
			od.price = product.price

			#####　合計金額の計算（クレカ決済用）　#####
			tax_included = od.price * 1.08
			subtotal_price = tax_included.to_i*od.product_count
			total_price += subtotal_price

			#####　在庫の削除　#####
			updated_stock = product.stock - od.product_count
			product.update_attributes(stock: updated_stock)
		end
		order.save!

		#####　クレジットカード決済処理　#####
		if order.payment_methods == "クレジットカード"
			#####　秘密鍵はベタうちせずに環境変数なるものを使った方がいいらしい。勉強予定。　#####
			Payjp.api_key = 'sk_test_421673bdeffac69c0df96e60'
			customer = Payjp::Customer.create(description: 'test')
			customer.cards.create(card: params['payjp-token'])
			Payjp::Charge.create(
				amount:   total_price + 500,
				customer: customer.id,
				currency: 'jpy'
			)
		end

		#####　カートの削除　#####
		cart_items = current_cart.cart_items
		cart_items.destroy_all
		redirect_to order_complete_path(order)
	end

	def update
		@order = Order.find(params[:id])
	end

	def complete
		@order = Order.find(params[:id])
	end

	def index
		#必要な情報は@order-historiesにまとめる
		user_orders = current_user.orders
		@order_histories = user_orders.each_with_object([]) do |user_order, array|
			next if user_order.order_details.blank?
			first_order_detail = user_order.order_details.first
			first_order_product = first_order_detail.product
			next if first_order_product.nil?
			array << {
				jacket_image: first_order_product.jacket_image_id,
				product_name: first_order_product.product_name,
				artist_name: first_order_product.artist&.name,
				product_count: first_order_detail.product_count,
				product_price: first_order_detail.price,
				shipment_status: user_order.shipment_status,
				created_at: user_order.created_at,
				order_destination: user_order.destination,
				order_id: user_order.id
			}
			end
	end

	def show
		#繰り返し処理が必要=>@order-history,繰り返し処理が不要=>@order
		@order = Order.find(params[:id])
		order_details = @order.order_details
		@total_price = 0
		@order_history = order_details.each_with_object([]) do |order_detail, array|
			order_product = order_detail.product
			array << {
				product_name: order_product.product_name,
				jacket_image: order_product.jacket_image_id,
				artist_name: order_product.artist.name,
				count: order_detail.product_count,
				price: order_detail.price
			}
		end
		# 合計金額の計算(取引詳細)
		@order_sub = []
		@order_history.each do |od|
			@subtotal = od[:price] * od[:count]
			@order_sub += [@subtotal]
			@total_price += @subtotal
		end
	end


	private


		def order_params
			params.require(:order).permit(:destination,
										  							:destination_name,
										  							:destination_postal_code,
										  							:destination_phone_number,
										  							:payment_methods,
										  							:shipment_status,
										   							order_details_attributes:  [:id,
										  																					:product_id,
									      																				:product_count])
		end

		def setup_order!
			@order_details = @order.order_details.build
			@cart_items = current_cart.cart_items
			@destinations = Destination.where(user_id: current_user.id)
		end

		def setup_destination!
			original_destination = Destination.new(user_id: current_user.id)
			original_destination.name = current_user.user_name
			original_destination.postal_code = current_user.postal_code
			original_destination.destination_address = current_user.postal_address
			original_destination.phone_number = current_user.phone_number
			original_destination.save!
		end

end
