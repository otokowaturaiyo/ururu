class Admins::HomeController < ApplicationController
  before_action :login_check
  def top
  end
end
