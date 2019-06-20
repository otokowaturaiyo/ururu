class OrdersController < ApplicationController


	def confirm
		@order = Order.new
		@order_details = @order.order_details.build
		@carts = Cart.where(user_id: current_user.id)
		@order.destination_name = current_user.user_name
		@order.destination_postal_code = current_user.postal_code
		@order.destination = current_user.postal_address
		@destinations = Destination.where(user_id: current_user.id)
  end

	def destinationupdate
		@order = Order.new(order_params)
		@order_details = @order.order_details.build
		@destinations = Destination.where(user_id: current_user.id)
		@carts = Cart.where(user_id: current_user.id)
		render action: "confirm"
	end

	def pay

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
		cart = Cart.where(user_id: current_user.id)
		cart.destroy_all
		redirect_to order_complete_path(order)
	end

	def update
		@order = Order.find(params[:id])
		# if @order.update(order_params)
		# 	redirect_to
	end

	def complete
		@order = Order.find(params[:id])
	end

	def index
		@orders = Order.all
	end

	def show
	end


	private

		def order_params
			params.require(:order).permit(:destination,
																		:destination_name,
																		:destination_postal_code,
																		:destination_phone_number,
																		:payment_methods,
																		order_details_attributes:  [:id,
																																:product_id,
																																:product_count])
		end
end
