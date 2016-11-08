require 'rails_helper'

RSpec.describe AccountType, type: :model do
  it "has a valid factory" do
    expect( FactoryGirl.build(:account_type) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end
end
