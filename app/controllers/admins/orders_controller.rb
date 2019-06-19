class Admins::OrdersController < ApplicationController
	def index
		@orders = Order.all
	end

	def edit
		@order = Order.find(params[:id])
		@user = User.find(params[:id])
		@order_details = OrderDetail.all
	end

	def upgate
		@order = Order.find(params[:id])
		if @order.update(order_params)
		   flash[:notice] = "更新完了！"
		   redirect_to edit_admins_product_order_path(@order.id)
		else
		   render :edit
		end
	end

	private
	def order_params
		params.require(:order).permit(:shipment_status)
	end
end
