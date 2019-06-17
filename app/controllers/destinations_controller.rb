class DestinationsController < ApplicationController

  #before_action :authenticate_destination!


  def new
  	@destination = Destination.new
    #下の記述はいらないかも
  	@user = current_user
  end

  def create
    @destination = Destination.new(destination_params)
    @user = current_user
    if @destination.save
       flash[:notice] = "新しい宛先を登録しました！"
       redirect_to user_path(@user.id)
    else
       render :'/destinations/new'
    end
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    @user = current_user
    if @destination.update(destination_params)
       flash[:notice] = "宛先を編集しました！"
       redirect_to user_path(@user.id)
    else
       render :'/destinations/edit'
    end
  end


  private

  def destination_params
    params.require(:destination).permit(:name, :phone_number, :postal_code, :destination_address)
  end

end