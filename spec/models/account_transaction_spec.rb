require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  it "has a valid factory" do
    @user = FactoryGirl.create(:user)
    @account = FactoryGirl.create(:account, user: @user, balance: 1000.00)
    expect( FactoryGirl.build(:account_transaction, account: @account) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:transaction_type) }
    #it { should validate_presence_of(:amount) }
    #it { should validate_presence_of(:prev_balance) }
    #it { should validate_presence_of(:new_balance) }

    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    # it { should validate_numericality_of(:prev_balance) }
    # it { should validate_numericality_of(:new_balance) }
  end

  describe "ActiveRecord Validations" do
    it { should belong_to(:account) }
    it { should validate_presence_of(:account) }
  end

  describe "After Save callbacks" do
    
    before(:each) do
      @balance = 1000.00
      @amount = 500.00
      @user = FactoryGirl.create(:user)
      @account = FactoryGirl.create(:account, user: @user, beginning_amount: @balance, balance: @balance)
    end

    context "transaction is type credit" do
      it "should store the previous balance" do
        @credit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 1, amount: @amount) #type 1 for credit
        expect(@credit.prev_balance).to eq(@balance)
      end

      it "should store the new balance" do
        @credit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 1, amount: @amount) #type 1 for credit
        expect(@credit.new_balance).to eq(@balance + @amount)
      end

      it "should add amount to account balance" do 
        @credit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 1, amount: @amount) #type 1 for credit
        expect(@account.balance).to eq(@balance + @amount)
      end
    end

    context "transaction is type debit" do
      it "should store the previous balance" do
        @debit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 2, amount: @amount) #type 2 for credit
        expect(@debit.prev_balance).to eq(@balance)
      end

      it "should store the new balance" do
        @debit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 2, amount: @amount) #type 2 for credit
        expect(@debit.new_balance).to eq(@balance - @amount)
      end

      it "should deduce amount from account balance" do 
        @debit = FactoryGirl.create(:account_transaction, account: @account, transaction_type: 2, amount: @amount) #type 2 for credit
        expect(@account.balance).to eq(@balance - @amount)
      end
    end
  end
end
