class ApplicationController < ActionController::Base

protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(sign_up, keys: [:kanji_lastname, :kanji_firstname, :kana_lastname, :kana_firstname, :user_name, :postal_code, :postal_address, :phone_number])
  	end

  	def after_sign_in_path_for(resource)
		if resource.is_a?(Admin)

			admins_top_path
		else
			users_root_path
		end
	end
	# def after_sign_out_path_for(resource)
	# end

end
