class ProductsController < ApplicationController
  PER = 6

  def index
  	@products = Product.page(params[:page]).per(PER)
  	@product = Product.find(params[:id])
  	@artists = artists.where(artist_id: product_id.artist.id)
  end

  def show
  end
end
