class Admins::HomeController < ApplicationController
	def after_sign_in_path_for(resource)
		admins_top_path
	end

	def after_sign_out_path_for(resource)
	  admins_top_path
	end

	def top
	end
end
