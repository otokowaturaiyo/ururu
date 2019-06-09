class ProductsController < ApplicationController
  PER = 6

  def index
  	@products = Product.all
  end

  def show
  end
end
