class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :create_original_destination!, only: [:confirm]

  def confirm
    @order = Order.new(
      destination: @original_destination.destination_address,
      destination_name: @original_destination.name,
      destination_postal_code: @original_destination.postal_code,
      destination_phone_number: @original_destination.phone_number
    )
    setup_order!
    retrieve_products_info(current_cart.cart_items)
    total_count(@items)
    fee_included(@items, :subtotal)
  end

  def destination_update
    @order = Order.new(order_params)
    setup_order!
    retrieve_products_info(current_cart.cart_items)
    total_count(@items)
    fee_included(@items, :subtotal)
    render action: "confirm"
  end

  def create
    order = Order.new(order_params)
    order.user_id = current_user.id
    retrieve_products_info(order.order_details)
    if order.save
      f = fee_included(@items, :subtotal).to_i
      if order.payment_methods == "クレジットカード"
        payjp(params['payjp-token'], f)
      end
      current_cart.cart_items.destroy_all
      redirect_to order_complete_path(order)
    else
      redirect_to order_confirm_path
    end
  end

  def update
    @order = Order.find(params[:id])
  end

  def complete
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_user.orders.includes(order_details: [product: [:artist, :label, :genre]]).page(params[:page]).per(5).order(created_at: :desc)
    first_order_details = @orders.map { |o| o.order_details.first }
    retrieve_products_info(first_order_details)
  end

  def show
    @order = Order.includes(:order_details).find(params[:id])
    @order_details = @order.order_details.page(params[:page]).per(5)
    retrieve_products_info(@order_details)
    fee_included(@items, :subtotal)
  end

  private

  def order_params
    params.require(:order).permit(:destination,
                                  :destination_name,
                                  :destination_postal_code,
                                  :destination_phone_number,
                                  :payment_methods,
                                  :shipment_status,
                                  order_details_attributes: [:id,
                                                             :product_id,
                                                             :product_count])
  end

  def setup_order!
    @order_details = @order.order_details.build
    @cart_items = current_cart.cart_items.includes(product: [:artist, :label, :genre])
    @destinations = Destination.where(user_id: current_user.id)
  end

  def create_original_destination!
    @original_destination = Destination.find_or_initialize_by(
      user_id: current_user.id,
      name: current_user.user_name,
      postal_code: current_user.postal_code,
      destination_address: current_user.postal_address,
      phone_number: current_user.phone_number
    )
    if @original_destination.new_record?
      @original_destination.save!
    end
  end
end
