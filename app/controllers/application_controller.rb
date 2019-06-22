class ApplicationController < ActionController::Base
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
			products_path
		end
	end

end
