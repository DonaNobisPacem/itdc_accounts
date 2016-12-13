class ActivitiesController < ApplicationController
  def index
    if params[:start_date].present? && params[:end_date].present?
      start_date = params[:start_date].to_datetime
      end_date = params[:end_date].to_datetime
      @activities = PublicActivity::Activity.where(created_at: start_date.beginning_of_day..end_date.end_of_day ).order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    else
      @activities = PublicActivity::Activity.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    end
  end
end
