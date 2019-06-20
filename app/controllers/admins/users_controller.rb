class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!
	def index
		query = { user_name_cont: params[:q] }
		@users = User.where(resignation: false).page(params[:page]).reverse_order
		q = User.where(resignation: false).ransack(query)
		if params[:q]
			@users = q.result(distinct: true).page(params[:page]).reverse_order
		end
	end

	def resign_index
		@users = User.where(resignation: true).page(params[:page]).reverse_order
		query = { user_name_cont: params[:q] }
		q = User.where(resignation: true).ransack(query)
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
		@user.update(
			resignation: true,
			resigned_at: Time.current
			)
		flash[:notice] = "ユーザーをブロックしました！"
		redirect_to admins_users_path
	end

	def revival
		@user = User.find(params[:id])
		@user.update(
			resignation: false,
			resigned_at: Time.current
			)
		flash[:notice] = "ユーザーを復活させました！"
		redirect_to admins_users_path
end
    private
	def users_params
		params.require(:user).permit(:user_id, :user_name, :email, :profile_image, :kanji_firstname, :kanji_lastname, :kana_firstname, :kana_lastname, :phone_number, :postal_code, :postal_address)
	end

end
