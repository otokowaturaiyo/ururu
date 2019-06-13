class DestinationsController < ApplicationController

  before_action :authenticate_destination!


  def new
  	@destination = Destination.new
    #下の記述はいらないかも
  	@user = current_user
  end

  def create
  end

  def edit
  end

  def update
  end

end

