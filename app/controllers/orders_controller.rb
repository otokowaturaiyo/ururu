class OrdersController < ApplicationController

	def confirm
	    @destination = Destination.where(user_id: current_user.id).first
	    @carts = Cart.where(user_id: current_user.id)
	    @order = Order.new
  	end

	def create
		order = Order.new(order_params)
		order.save
		# order_detail = Order_detail.new(order_detail_params)
		# order_detail.save
		redirect_to order_complete_path(order.id)
	end

	def update
		@order = Order.find(params[:id])
		# if @order.update(order_params)
		# 	redirect_to
	end

	def complete
		@order_id = params[:id]
	end

	def index
		@orders = Order.all
	end

	def show
	end

	private

	def order_params
		params.require(:order).permit(:user_id, :destination, :payment_methods, order_details:[
			:product_count, :price, :product_id, :order_id, :_destroy
		])
	end

	# def order_detail_params
	# 	params.require(:order_detail).permit()
	# end



end
