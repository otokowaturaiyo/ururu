class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	# before_action
	def index
		query = { user_name_cont: params[:q] }
		@users = User.page(params[:page]).reverse_order
		q = User.ransack(query)
		if params[:q]
			@users = q.result(distinct: true).page(params[:page]).reverse_order
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(users_params)
		 	flash[:notice] = "更新完了！"
		redirect_to admins_user_path(@user.id)
	else
		render :edit
	end
	end
	def resign
		@user = User.find(params[:id])
		@user.update(resignation: false)
		flash[:notice] = "ユーザーをブロックしました！"
		redirect_to admins_users_path
	end

    private
	def users_params
		params.require(:user).permit(:user_id, :user_name, :email, :profile_image)
	end

end