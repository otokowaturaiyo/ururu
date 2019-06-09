class ProductsController < ApplicationController
  PER = 6

  def index
  	@products = Product.page(params[:page]).per(PER)
  end

  def show
  end
end
