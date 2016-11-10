class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, except: [:show]
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.paginate(page: params[:page], per_page: 30)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    order = params[:o].present? ? params[:o] : "asc"
    page_limit = params[:p].present? ? params[:p] : 30
    @account_transactions = @account.account_transactions.order(created_at: order).paginate(page: params[:page], per_page: page_limit)
  end

  # GET /accounts/new
  def new
    @user =
      if params[:user_id].present?
        User.where(id: params[:user_id]).first
      elsif params[:account][:user_id].present?
        User.where(id: params[:account][:user_id]).first
      else
        #something is not right
      end
    @account = Account.new( user_id: @user.id )
  end

  # GET /accounts/1/edit
  # def edit
  # end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @user =
      if params[:user_id].present?
        User.where(id: params[:user_id]).first
      elsif params[:account][:user_id].present?
        User.where(id: params[:account][:user_id]).first
      else
        #something is not right
      end
      
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  # def update
  #   respond_to do |format|
  #     if @account.update(account_params)
  #       format.html { redirect_to @account, notice: 'Account was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @account }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @account.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /accounts/1
  # # DELETE /accounts/1.json
  # def destroy
  #   @account.destroy
  #   respond_to do |format|
  #     format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:account_type, :beginning_amount, :balance, :user_id)
    end
end
