class Admins::ProductsController < ApplicationController
  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)
    @genres = Genre.all
    if @product.save
      flash[:notice] = "新規商品の登録完了しました。"
      redirect_to admins_product_path(@product)
    else
      render 'new'
    end
  end

  def index
    @products = Product.page(params[:page])
  end

  def edit
    find_product
    @genres = Genre.all
  end

  def update
    find_product
    @genres = Genre.all
    if @product.update(product_params)
      flash[:notice]="更新完了しました。"
      redirect_to admins_product_path(@product)
    else
      render 'edit'
    end
  end

  def show
    find_product
  end


  private


    # ジャンル等まとめて商品情報を引っ張ってくる
    def find_product
      @product = Product.find(params[:id])
      @artist = Artist.find(@product.artist_id)
      @genre = Genre.find(@product.genre_id)
      @label = Label.find(@product.label_id)
    end

    def product_params
      params.require(:product).permit(:genre_id, :artist_id, :label_id, 
                                      :product_name, :price, :description,
                                      :jacket_image, 
                                      :stock, :recommend, :status)
    end

end