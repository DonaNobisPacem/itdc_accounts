class AccountTransactionsController < ApplicationController
  before_action :set_account_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, except: [:show]
  before_action :validate_user
  # GET /account_transactions
  # GET /account_transactions.json
  def index
    @account_transactions = AccountTransaction.paginate(page: params[:page], per_page: 30)
  end

  # GET /account_transactions/1
  # GET /account_transactions/1.json
  def show
  end

  # GET /account_transactions/new
  def new
    @account = 
      if params[:account_id].present? 
        Account.where(id: params[:account_id]).first
      elsif params[:account_transaction][:account_id].present?
        Account.where(id: params[:account_transaction][:account_id]).first
      else
        #something went wrong
      end
    @transaction_type = 
      if params[:transaction_type].present? 
        TransactionType.where(id: params[:transaction_type]).first
      elsif params[:account_transaction][:transaction_type].present?
        TransactionType.where(id: params[:account_transaction][:transaction_type]).first
      else
        #something went wrong
      end
    @account_transaction = AccountTransaction.new(account_id: params[:account_id], transaction_type: params[:transaction_type])
  end

  # GET /account_transactions/1/edit
  # def edit
  # end

  # POST /account_transactions
  # POST /account_transactions.json
  def create
    @account_transaction = AccountTransaction.new(account_transaction_params)
    @account = 
      if params[:account_id].present? 
        Account.where(id: params[:account_id]).first
      elsif params[:account_transaction][:account_id].present?
        Account.where(id: params[:account_transaction][:account_id]).first
      else
        #something went wrong
      end
    @transaction_type = 
      if params[:transaction_type].present? 
        TransactionType.where(id: params[:transaction_type]).first
      elsif params[:account_transaction][:transaction_type].present?
        TransactionType.where(id: params[:account_transaction][:transaction_type]).first
      else
        #something went wrong
      end

    respond_to do |format|
      if @account_transaction.save
        format.html { redirect_to @account_transaction, notice: 'Account transaction was successfully created.' }
        format.json { render :show, status: :created, location: @account_transaction }
      else
        format.html { render :new }
        format.json { render json: @account_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_transactions/1
  # PATCH/PUT /account_transactions/1.json
  # def update
  #   respond_to do |format|
  #     if @account_transaction.update(account_transaction_params)
  #       format.html { redirect_to @account_transaction, notice: 'Account transaction was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @account_transaction }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @account_transaction.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /account_transactions/1
  # DELETE /account_transactions/1.json
  # def destroy
  #   @account_transaction.destroy
  #   respond_to do |format|
  #     format.html { redirect_to account_transactions_url, notice: 'Account transaction was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_transaction
      @account_transaction = AccountTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_transaction_params
      params.require(:account_transaction).permit(:transaction_type, :amount, :prev_balance, :new_balance, :description, :account_id)
    end
end
