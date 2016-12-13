class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  #before_action :authenticate_admin
  include PublicActivity::StoreController
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    # devise_parameter_sanitizer.for(:account_update) << :last_name
  end

  def authenticate_admin
    if current_user.admin 
      return
    else
      redirect_to forbidden_path
    end
  end

  def validate_user
    if current_user.validated
      return
    else
      redirect_to tos_path
    end
  end
end
