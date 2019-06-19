class OrdersController < ApplicationController

	def confirm
	    @destination = Destination.where(user_id: current_user.id).first
	    @carts = Cart.where(user_id: current_user.id)
  	end

	def create
		order = Order.new(order_params)
		order.save
		cart = Cart.where(user_id: current_user.id)
		cart.destroy_all
		redirect_to order_complete_path(order.id)
	end

	def complete
		@order_id = params[:id]
	end

	def index
	end

	def show
	end

	private

	def order_params
		params.require(:order).permit(:user_id, :destination)
	end


end
