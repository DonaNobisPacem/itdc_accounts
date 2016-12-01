class ReportsController < ApplicationController
  before_action :authenticate_admin
  before_action :validate_user
  
  def index
  end

  def summary_of_reports
    if params[:at].present?
      @account_type = AccountType.find_by_id(params[:at])
      @accounts_total = Account.where(account_type: params[:at]).joins(:user).order('users.last_name')
      @accounts = Account.where(account_type: params[:at]).joins(:user).order('users.last_name').paginate(page: params[:page], per_page: 30)
    end

    respond_to do |format|
      format.html
      format.csv { send_data Account.to_csv(@accounts_total), filename: "summary_of_reports_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}.csv" }
      # format.pdf do
      #   render pdf: "summary_of_reports_#{Time.now.strftime("%^b-%d-%Y-%H-%M")}",
      #     template: "reports/summary_of_reports.pdf.erb",
      #     locals: {
      #       accounts: @accounts_total,
      #       account_type: @account_type
      #     }
      # end
      format.pdf do
        render pdf: "test_pdf",
          template: "reports/test_pdf.pdf.erb"
      end
    end
  end
end
