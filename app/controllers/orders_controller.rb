class OrdersController < ApplicationController

	def confirm
		@destination = Destination.find_by(params[:id]).order(created_at: :desc).limit(1)
		
	end


	def create
	end

	def complete
	end

	def index
	end

	def show
	end



end
