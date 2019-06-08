class Admins::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create

  end

  def index
    @products = Product.page(params[:page])
  end

  def edit

  end

  def update

  end

  def show

  end
end