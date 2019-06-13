class ProductsController < ApplicationController
  PER = 6
  PER2 =30

  def index
  	@products = Product.page(params[:page]).per(PER).order(created_at: :desc)
  	@recommends = Product.where(recommend: true).order(created_at: :desc).limit(PER)
  	@genres = Genre.all
  end

  def show
    find_product
	@disks = @product.disks
  end

  def feature
  	@products = Product.page(params[:page]).per(PER).order(created_at: :desc)
  	@recommend = Product.where(recommend: true)
  end

  def search_list
  	@products = Product.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
  end



  private

  def product_params
  	params.require(:product).permit(:jacket_image_id, :product_name, :artist_id)
  end

  def find_product
      @product = Product.find(params[:id])
      @artist = Artist.find(@product.artist_id)
      @genre = Genre.find(@product.genre_id)
      @label = Label.find(@product.label_id)
  end

end
