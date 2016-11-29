class ReportsController < ApplicationController
  before_action :authenticate_admin
  before_action :validate_user
  
  def index
  end

  def summary_of_reports
    if params[:at].present?
      @account_type = AccountType.find_by_id(params[:at])
      @accounts_total = Account.where(account_type: params[:at])
      @accounts = Account.where(account_type: params[:at]).joins(:user).order('users.last_name').paginate(page: params[:page], per_page: 30)
    end
  end
end
