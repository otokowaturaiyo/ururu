class Admins::HomeController < ApplicationController
	before_action :login_check
	def top
	end
	 private

  def login_check
	  unless admin_signed_in?
	    redirect_to new_user_session_path
	  end
	end

end
