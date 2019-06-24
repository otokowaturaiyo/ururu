class ApplicationController < ActionController::Base


	before_action :configure_permitted_parameters, if: :devise_controller?


	def resignation_user?
		if user_signed_in?
			if current_user.resignation == true
				sign_out(current_user)
			end
		end
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:kanji_lastname, :kanji_firstname, :kana_lastname, :kana_firstname, :user_name, :postal_code, :postal_address, :phone_number])
  	end

  	def after_sign_in_path_for(resource)
		if resource.is_a?(Admin)

			admins_top_path
		else
			products_path
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
