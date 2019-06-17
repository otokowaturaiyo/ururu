class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update]

  def show
  	@user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  	if @user.update(user_params)
       sign_in(@user, bypass: true)
       flash[:notice] = "編集内容を更新しました！"
  	   redirect_to user_path(@user.id)
    else
       render :'/users/edit'
    end
  end

    def resign
      @user = User.find(params[:id])
    end

    def resign_confirm
      @user = User.find(params[:id])
      @user.update(resignation: true)
      flash[:notice] = "退会しました。"
      redirect_to products_path
    end





private

  def user_params
        params.require(:user).permit(:kanji_lastname, :kanji_firstname, :kana_lastname, :kana_firstname, :user_name, :postal_code, :postal_address, :phone_number, :profile_image_url, :email, :password)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  # def user_password_params
  #       params.require(:user).permit(:password)
  # end
end

