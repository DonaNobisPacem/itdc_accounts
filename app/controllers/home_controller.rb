class HomeController < ApplicationController
  def index
    if current_user.admin
      @users = User.paginate(page: params[:page], per_page: 30) 
    end
  end
end
