class ReportsController < ApplicationController
  before_action :authenticate_admin
  before_action :validate_user
  
  def index
  end

  def summary_of_reports
  end
end
