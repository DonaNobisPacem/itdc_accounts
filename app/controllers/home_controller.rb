class HomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:unregistered]
  before_action :validate_user, except: [:tos, :unregistered]
  
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
    if current_user.validated
      redirect_to root_path
    end
  end
end
