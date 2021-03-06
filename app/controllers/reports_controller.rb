class ReportsController < ApplicationController
  before_action :authenticate_admin
  before_action :validate_user
  
  def index
  end

  def summary_of_accounts
    if params[:at].present?
      @account_type = AccountType.find_by_id(params[:at])
      @accounts_total = Account.where(account_type: params[:at]).joins(:user).order('users.last_name')
      @accounts = Account.where(account_type: params[:at]).joins(:user).order('users.last_name').paginate(page: params[:page], per_page: 30)
      pdf = SummaryOfAccountsPdf.new(@accounts_total)
    end

    respond_to do |format|
      format.html
      format.csv { send_data Account.to_csv(@accounts_total), filename: "summary_of_reports_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}.csv" }
      format.pdf { send_data pdf.render, filename: "summary_of_reports_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}.pdf", type: 'application/pdf', disposition: 'inline' }
    end
  end

  def account_details
    if params[:aid].present?
      @account = Account.find_by_id(params[:aid])
      @accounts = @account.user.accounts
      @account_transactions = @account.account_transactions.order(created_at: :asc)
      pdf = AccountDetailsPdf.new(@account)

      respond_to do |format|
        format.html
        format.csv { send_data @account.accd_to_csv, filename: "#{@account.owner_name}_account_details_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}.csv" }
        format.pdf { send_data pdf.render, filename: "#{@account.owner_name}_account_details_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}.pdf", type: 'application/pdf', disposition: 'inline' }
      end
    else
      redirect_to reports_path, flash: { error: "No Account Selected." }
    end
  end

  def accd_get_accounts
    if params[:user_id].present?
      @accd_user = User.find_by_id(params[:user_id])
      @accd_accounts = @accd_user.accounts
    else
      @accd_accounts = []
    end

    respond_to do |format|
      format.js
    end
  end
end
