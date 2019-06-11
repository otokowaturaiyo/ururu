class JenresController < ApplicationController
	PER =15


	def show
		@genre = Genre.find(params[:id])
		@products = @genre.products.page(params[:page]).per(PER).order(created_at: :desc)
	end


	private


	def jenre_params
		params.require(:genre).permit(:genre)
	end

	def product_params
  		params.require(:product).permit(:product_name, :artist_id)
  end
end
