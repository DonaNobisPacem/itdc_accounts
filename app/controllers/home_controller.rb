class HomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:unregistered]
  
  def index
    if current_user.admin
      @users = User.paginate(page: params[:page], per_page: 30) 
    else
      @user = current_user
      @accounts = @user.accounts.paginate(page: params[:page], per_page: 30)
    end
  end

  def forbidden
  end

  def unregistered
  end

  def tos
  end
end
