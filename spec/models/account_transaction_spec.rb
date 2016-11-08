require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  it "has a valid factory" do
    expect( FactoryGirl.build(:account_transaction) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:transaction_type) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:prev_balance) }
    it { should validate_presence_of(:new_balance) }

    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    # it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end

  describe "ActiveRecord Validations" do
    it { should belong_to(:account) }
    it { should validate_presence_of(:account) }
  end

  describe "After Save callbacks" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      @account = FactoryGirl.create(:account, user: @user, balance: 1000.00)
    end

    context "transaction is type credit" do
      it "should add amount to account balance" do 
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 1, amount: 100.00) #type 1 for credit
        @credit.save
        expect(@account.balance).to eq(1100.00)
      end

      it "should store the previous balance" do
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 1, amount: 100.00) #type 1 for credit
        @credit.save
        expect(@credit.prev_balance).to eq(1000.00)
      end

      it "should store the new balance" do
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 1, amount: 100.00) #type 1 for credit
        @credit.save
        expect(@credit.new_balance).to eq(1100.00)
      end
    end

    context "transaction is type debit" do
      it "should deduce amount from account balance" do 
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 2, amount: 100.00) #type 2 for credit
        @credit.save
        expect(@account.balance).to eq(900.00)
      end

      it "should store the previous balance" do
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 2, amount: 100.00) #type 2 for credit
        @credit.save
        expect(@credit.prev_balance).to eq(1000.00)
      end

      it "should store the new balance" do
        @credit = FactoryGirl.build(:account_transaction, account: @account, transaction_type: 2, amount: 100.00) #type 2 for credit
        @credit.save
        expect(@credit.new_balance).to eq(900.00)
      end
    end
  end
end
