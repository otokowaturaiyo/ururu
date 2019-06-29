class ApplicationController < ActionController::Base
  before_action :resignation_user?
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
      return @cart
    end
  end

  def retrieve_products_info(items)
    @items = items.each_with_object([]) do |item, array|
      p = item.product
      o = item.try(:order)
      array << {
        id: item.id,
        product_id: p.id,
        product_name: p.product_name,
        image: p.jacket_image_id,
        artist: p.artist.name,
        label: p.label.label,
        genre: p.genre.genre,
        count: item.product_count,
        price: p.price * 1.08,
        subtotal: item.product_count * p.price * 1.08,
        shipment_status: o&.shipment_status,
        created_at: o&.created_at,
        order_destination: o&.destination,
        order_id: o&.id
      }

    end
  end

  def resignation_user?
    if user_signed_in?
      if current_user.resignation == true
        sign_out(current_user)
      end
    end
  end

  def login_check
    unless admin_signed_in?
      redirect_to root_path
    end
end

  def total_price(items, subtotal)
    @total_price = items.sum { |hash| hash[:subtotal] }.to_i
  end

  def fee_included(items, subtotal)
    total_price = items.sum { |hash| hash[subtotal] }.to_i
    fee_included = total_price + 500
    @total_price_with_fee = fee_included
  end

  def total_count(items)
    @total_count = items.sum { |hash| hash[:count] }
  end

  def payjp(payjp_token, amount)
    Payjp.api_key = ENV['PAYJP_KEYS']
    customer = Payjp::Customer.create(description: 'test')
    customer.cards.create(card: payjp_token)
    Payjp::Charge.create(
      amount: amount,
      customer: customer.id,
      currency: 'jpy'
    )
  end

private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kanji_lastname, :kanji_firstname, :kana_lastname, :kana_firstname, :user_name, :postal_code, :postal_address, :phone_number])
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admins_top_path
    else
      stored_location_for(resource_or_scope) || super
    end
  end

  def after_sign_out_path_for(resource)
    if resource.is_a?(Admin)
      new_admin_session_path
    else
      root_path
    end
  end
end
