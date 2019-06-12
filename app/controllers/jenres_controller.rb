class JenresController < ApplicationController
	PER =15


	def show
		@jenre = Jenre.find(params[:id])
		@products = @jenre.products.page(params[:page]).per(PER).order(created_at: :desc)
	end


	private


	def jenre_params
		params.require(:jenre).permit(:jenre)
	end

	def product_params
  		params.require(:product).permit(:product_name, :artist_id)
  end
end
