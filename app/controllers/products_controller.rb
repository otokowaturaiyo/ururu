class ProductsController < ApplicationController
  PER = 9
  PER2 = 6
  PER3 = 30

  def index
  	@products = Product.page(params[:page]).per(PER).order(created_at: :desc)
  	@recommends = Product.where(recommend: true).order(created_at: :desc).limit(PER2)
  	@genres = Genre.all
  end

  def show
    find_product
    @disks = @product.disks
    @review =Review.new
    @reviews = @product.reviews
    @cart = Cart.new
  end

  def feature
  	@products = Product.page(params[:page]).per(PER2).order(created_at: :desc)
  	@recommend = Product.where(recommend: true)
  end

  def search_list
  	@products = Product.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
    @artists = Artist.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
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
