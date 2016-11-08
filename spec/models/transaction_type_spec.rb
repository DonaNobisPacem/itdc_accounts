require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  it "has a valid factory" do
    expect( FactoryGirl.build(:transaction_type) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end
end
