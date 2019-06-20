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

	def create
		order = Order.new(order_params)
		order.user_id = current_user.id
		order.order_details.each do |od|
			product = Product.find(od.product_id)
			od.price = product.price
		end
		order.save!
		cart = Cart.where(user_id: current_user.id)
		cart.destroy_all
		redirect_to order_complete_path(order)
	end

	def update
		@order = Order.find(params[:id])
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

	# def order_detail_params
	# 	params.require(:order_detail).permit()
	# end


end
