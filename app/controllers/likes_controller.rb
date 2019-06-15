class LikesController < ApplicationController
	# before_action :authenticate_user!, :authenticate_admin!
	def create
		product = Product.find(params[:product_id])
		likes = current_user.likes.new(product_id: product.id)
		likes.save
		redirect_to product_path(product.id)
	end
	def destroy
		product = Product.find(params[:product_id])
		likes = current_user.likes.find_by(product_id: product.id)
		likes.destroy
		redirect_to product_path(product.id)
	end
end



