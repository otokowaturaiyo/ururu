class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
	if resouce.is_a?(AdminUser)
		admins_top_path
	else
		users_root_path
	end
end
	# def after_sign_out_path_for(resource)
	# end
end
