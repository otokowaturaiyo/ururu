class ApplicationController < ActionController::Base
	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(sign_up, keys: [:kanji_lastname, :kanji_firstname, :kana_lastname, :kana_firstname, :user_name, :postal_code, :postal_address, :phone_number])
end
