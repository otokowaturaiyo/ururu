class ProductsController < ApplicationController
  before_action :resignation_user?, only: [:index]

  before_action :setup_products, only: [:index, :show, :feature, :search_list]
  PER = 9
  PER2 = 6

  def index
    @products = @all_products.page(params[:page]).per(PER).order(created_at: :desc)
    @recommends = @all_products.where(recommend: true).order(created_at: :desc).limit(PER2)
    @genres = Genre.all
  end

  def show
    @product = @all_products.find(params[:id])
    @tax_included = @product.price * 1.08
    @review = Review.new
    @reviews = @product.reviews
  end

  def feature
    @products = @all_products.page(params[:page]).per(PER2).order(created_at: :desc)
    @recommend = @all_products.where(recommend: true)
  end

  def search_list
    @products = @all_products.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
    @artists = Artist.search(params[:search]).page(params[:page]).per(PER2).order(created_at: :desc)
  end

  private

  def product_params
    params.require(:product).permit(:jacket_image_id, :product_name, :artist_id)
  end

  def setup_products
    @all_products = Product.includes(:artist, :label, :genre).all
  end
end
