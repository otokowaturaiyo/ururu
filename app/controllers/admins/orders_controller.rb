class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!
	PER = 10


	def index
		@orders = Order.page(params[:page]).per(PER)
	end

	def edit
		@order = Order.find(params[:id])
		@user = User.find(@order.user_id)
		@order_details = OrderDetail.where(order: @order)
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
		   flash[:notice] = "更新完了！"
		   redirect_to edit_admins_order_path(@order.id)
		else
		   render :edit
		end
	end

	private
	def order_params
		params.require(:@order).permit(:shipment_status)
	end
end

