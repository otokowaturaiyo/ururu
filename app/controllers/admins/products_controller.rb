class Admins::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product = Product.new
    if product.save
      flash[:notice] = "新規商品の登録完了"
      redirect_to product_path(product)
    else
      render 'new'
    end
  end

  def index
    @products = Product.page(params[:page])
  end

  def edit

  end

  def update

  end

  def show
    @product = Product.find(params[:id])
    @artist = Artist.find(@product.artist_id)
    @genre = Genre.find(@product.genre_id)
    @label = Label.find(@product.label_id)
  end
end