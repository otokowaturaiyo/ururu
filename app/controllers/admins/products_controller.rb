class Admins::ProductsController < ApplicationController

  def new
    @product = Product.new
    @disk = @product.disks.build
    @song = @disk.songs.build
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)

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
      @disks = Disk.where(product_id: @product.id)
      @artist = Artist.find(@product.artist_id)
      @genre = Genre.find(@product.genre_id)
      @label = Label.find(@product.label_id)
    end

    def product_params
      params.require(:product).permit(:id,
                                      :genre_id,
                                      :artist_id,
                                      :label_id,
                                      :product_name,
                                      :price,
                                      :description,
                                      :jacket_image,
                                      :stock,
                                      :recommend,
                                      :status,
                                      disks_attributes:  [:id,
                                                          :product_id,
                                                          :_destroy,
                                                          songs_attributes: [:id,
                                                                             :disks_id,
                                                                             :song,
                                                                             :second,
                                                                             :_destroy]])
    end

end
