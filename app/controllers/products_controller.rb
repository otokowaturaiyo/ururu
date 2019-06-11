class ProductsController < ApplicationController
  PER = 6
  PER2 =15

  def index
  	@products = Product.page(params[:page]).per(PER).order(created_at: :desc)
  	@recommend = Product.where(recommend: true)
  end

  def show
    @product = Product.find(params[:id])
	@artist = Artist.find(@product.artist_id)
	@genre = Genre.find(@product.genre_id)
	@label = Label.find(@product.label_id)
	@disks = @product.disks
  end

  def search_list
  	@products = Product.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
  end





end
