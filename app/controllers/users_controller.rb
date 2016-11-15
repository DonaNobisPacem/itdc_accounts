class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, except: [:show, :edit]
  before_action :restrict_user_to_self, only: [:show, :edit]
  before_action :validate_user

  # GET /users
  # GET /users.json
  def index
    if params[:q].present? || params[:t].present?
      search = params[:q].present? ? params[:q] : "*"
      where = {}
      where[:admin] = params[:t] if params[:t].present?

      @users = User.search search, where: where
    else
      @users = User.paginate(page: params[:page], per_page: 30)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @accounts = @user.accounts.paginate(page: params[:page], per_page: 30)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token[0,20]

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_later
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :admin, :validated)
    end

    def restrict_user_to_self
      if current_user.admin
        return
      else
        if current_user.id == @user.id
          return
        else
          redirect_to forbidden_path
        end
      end
    end
end
