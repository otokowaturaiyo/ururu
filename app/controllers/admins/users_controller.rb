class Admins::UsersController < ApplicationController
	def index
		@users = User.all.page(params[:page]).reverse_order
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(users_params)
		flash[:notice] = "更新完了！"
		redirect_to admins_user_path(@user.id)
	end

	private
	def users_params
		params.require(:user).permit(:user_id, :user_name, :email, :profile_image_url)
	end

end
