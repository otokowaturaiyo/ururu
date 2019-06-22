class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:update_item, :delete_item]

  def show
    @cart_items = current_cart.cart_items
  end

  def add_item
    cart_item = current_cart.cart_items&.find_or_initialize_by(product_id: params[:product_id])
    if cart_item.new_record?
      product = Product.find(cart_item.product_id)
      cart_item = current_cart.cart_items.build(cart_params)
      cart_item.product_price = product.price
      cart_item.save!
    else
      updated_count = cart_item.product_count.to_i + params[:cart][:product_count].to_i
      cart_item.update_attributes!(product_count: updated_count)
    end
    redirect_to current_cart
  end


  def update
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.update(cart_params)
    redirect_to current_cart
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to current_cart
  end

  private

    def setup_cart_item!
      @cart_item = current_cart.cart_items.find(params[:id])
    end

    def cart_params
      params.permit(:product_id, :product_count)
    end



end
