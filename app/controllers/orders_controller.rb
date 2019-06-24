class OrdersController < ApplicationController
	before_action :authenticate_user!


	def confirm
		if user_signed_in?
			@order = Order.new
			@order_details = @order.order_details.build
			@cart_items = current_cart.cart_items
			@order.destination_name = current_user.user_name
			@order.destination_postal_code = current_user.postal_code
			@order.destination = current_user.postal_address
			@destinations = Destination.where(user_id: current_user.id)
		else
			redirect_to new_user_session_path
		end
  end

	def destinationupdate
		@order = Order.new(order_params)
		@order_details = @order.order_details.build
		@destinations = Destination.where(user_id: current_user.id)
		@cart_items = current_cart.cart_items
		render action: "confirm"
	end

	def create
		##### 注文を作成　#####
		order = Order.new(order_params)
		order.user_id = current_user.id
		order.create_order(params['payjp-token'])
		order.save!

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
		@order_histories = build_order_histories(user_orders)
	end

	def show
		#繰り返し処理が必要=>@order-history,繰り返し処理が不要=>@order
		@order = Order.find(params[:id])
		order_details = @order.order_details
		@total_price = 0
		@order_history = build_order_history(order_details)

		# 合計金額の計算(取引詳細) <= ここモデルにまとめられそう
		@order_history.each do |od|
			@subtotal = od[:price] * od[:count]
			@total_price += @subtotal
		end
	end


	private


		def order_params
			params.require(:order).permit(  :destination,
				  							:destination_name,
				  							:destination_postal_code,
				  							:destination_phone_number,
				  							:payment_methods,
				  							:shipment_status,
				   							order_details_attributes:  [:id,
																		:product_id,
																		:product_count])
		end


		def build_order_histories(user_orders)
			@order_histories = user_orders.each_with_object([]) do |user_order, array|
				#ここから本当はいらない
				next if user_order.order_details.blank?
				first_order_detail = user_order.order_details.first
				first_order_product = first_order_detail.product
				next if first_order_product.nil?
				#ここまで本当はいらない
				array << {
					jacket_image: first_order_product.jacket_image_id,
					product_name: first_order_product.product_name,
					artist_name: first_order_product.artist.name,
					product_count: first_order_detail.product_count,
					product_price: first_order_detail.price,
					shipment_status: user_order.shipment_status,
					created_at: user_order.created_at,
					order_destination: user_order.destination,
					order_id: user_order.id
				}
			end
		end

		def build_order_history(order_details)
			order_details.each_with_object([]) do |order_detail, array|
			  order_product = order_detail.product
			  array << {
				product_name: order_product.product_name,
				jacket_image: order_product.jacket_image_id,
				artist_name: order_product.artist.name,
				count: order_detail.product_count,
				price: order_detail.price
			  }
			end
		end

end
