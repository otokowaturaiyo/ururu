class ProductsController < ApplicationController
  PER = 6

  def index
  	@products = Product.page(params[:page]).per(PER).order(created_at: :desc)
  end

  def show
  end

  def search
  	@products = Product.search(params[:search])
  end


end
