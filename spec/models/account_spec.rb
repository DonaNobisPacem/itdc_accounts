require 'rails_helper'

RSpec.describe Account, type: :model do
  it "has a valid factory" do
    @user = FactoryGirl.create(:user)
    expect( FactoryGirl.build(:account, user: @user) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:account_type) }
    #it { should validate_presence_of(:beginning_amount) }
    #it { should validate_presence_of(:balance) }

    it { should validate_numericality_of(:beginning_amount).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:balance) }
  end

  describe "ActiveRecord Validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:user) }

    it { should have_many(:account_transactions) }
    it { should accept_nested_attributes_for(:account_transactions).allow_destroy(true) }
  end

  describe "Custom callback validations" do
    it "should have Beginning amount == Balance after creation" do
      @user = FactoryGirl.create(:user)
      @account = FactoryGirl.create(:account, user: @user, beginning_amount: 1000.00)
      expect(@account.balance).to eq(@account.beginning_amount)
    end
  end
end
