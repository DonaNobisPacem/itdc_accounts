class HomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:unregistered]
  before_action :validate_user, except: [:tos, :unregistered]
  
  def index
    if current_user.admin
      @users = User.paginate(page: params[:page], per_page: 30)
      @announcements = Announcement.where(visible_to_admins: true).where("start_date <= ?", Date.today ).order(start_date: :desc).limit(3)
    else
      @user = current_user
      @announcements = Announcement.where(visible_to_users: true).where("start_date <= ?", Date.today ).order(start_date: :desc).limit(3)
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
