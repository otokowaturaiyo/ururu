class CartsController < ApplicationController

  def create
    if user_signed_in?
      @cart = Cart.new(cart_params)
      @cart.user_id = current_user.id
      @cart.save
      redirect_to cart_path(@cart.user_id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    user = User.find(params[:id])
    @carts = Cart.where(user_id: user.id)
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to cart_path(@cart.user_id)
    else
      render 'show'
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
		redirect_to cart_path(@cart.user_id)
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id, :product_id, :product_count, :product_price)
  end


end
