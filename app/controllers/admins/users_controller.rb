class Admins::UsersController < ApplicationController
	def index
		@users = User.all
		# @user = User.find(params[:id])
	end

	def show
	end

	def edit
	end

	def update
	end

	private
	def users_params
		params.require(:user).permit(:user_id, :user_name, :email, :profile_image_url)
	end

end
