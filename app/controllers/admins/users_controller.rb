class Admins::UsersController < ApplicationController

	def index
		@users = User.all
		@q = User.ransack(params[:q])
		if params[:q]
			@users = @q.result(distinct: true)
		end
	end
	def search
		@q = User.search(search_params)
		@user= @q.result(distinct: true)
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
		if flash[:notice] = "更新完了！"
		redirect_to admins_user_path(@user.id)
	else
		render :edit
	end
	end

	private
	def users_params
		params.require(:user).permit(:user_id, :user_name, :email, :profile_image)
	end
	def search_params
		params.require(:q).permit!
	end
end
