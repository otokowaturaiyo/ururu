class CartsController < ApplicationController

  def create
    if user_signed_in?
      cart = Cart.find_or_initialize_by(product_id: params[:cart][:product_id])
      if cart.new_record?
        product = Product.find(cart.product_id)
        cart = Cart.new(cart_params)
        cart.product_price = product.price
        cart.user_id = current_user.id
        cart.save!
      else
        updated_count = cart.product_count.to_i + params[:cart][:product_count].to_i
        cart.update_attributes!(product_count: updated_count)
      end
      redirect_to cart_path(cart.user_id)
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
    params.require(:cart).permit(:product_id, :product_count)
  end


end
