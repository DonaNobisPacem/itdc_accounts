class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, except: [:show, :index]
  before_action :validate_user

  # GET /announcements
  # GET /announcements.json
  def index
    if current_user.admin?
      @announcements = Announcement.order(start_date: :desc).paginate(page: params[:page], per_page: 30)
    else
      @announcements = Announcement.where(visible_to_users: true).where("start_date <= ?", Date.today ).order(start_date: :desc).paginate(page: params[:page], per_page: 30)
    end
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    if !current_user.admin && !@announcement.visible_to_users
      redirect_to forbidden_path
    end
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        @announcement.create_activity :create, owner: current_user, ip_address: current_user.current_sign_in_ip
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        @announcement.create_activity :update, owner: current_user, ip_address: current_user.current_sign_in_ip
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:subject, :message, :visible_to_users, :visible_to_admins, :start_date)
    end
end
