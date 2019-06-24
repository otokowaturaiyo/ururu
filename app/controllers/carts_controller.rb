class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:update, :destroy]

  def show
    retrieve_products_info(current_cart.cart_items)
    total_count(@items)
    fee_included(@items, :subtotal)
  end

  def add_item
    cart_item = current_cart.cart_items&.find_or_initialize_by(product_id: params[:cart_item][:product_id])
    if cart_item.new_record?
      product = Product.find(cart_item.product_id)
      cart_item = current_cart.cart_items.build(cart_params)
      cart_item.product_price = product.price
      cart_item.save!
    else
      updated_count = cart_item.product_count.to_i + params[:cart_item][:product_count].to_i
      cart_item.update_attributes!(product_count: updated_count)
    end
    redirect_to current_cart
  end

  def update
    @cart_item.update(cart_params)
    redirect_to current_cart
  end

  def destroy
    @cart_item.destroy
    redirect_to current_cart
  end

  private

  def setup_cart_item!
    @cart_item = current_cart.cart_items.find(params[:id])
  end

  def cart_params
    params.require(:cart_item).permit(:product_id, :product_count)
  end
end
