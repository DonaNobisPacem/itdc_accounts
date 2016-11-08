require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect( FactoryGirl.build(:user) ).to be_valid 
  end

  describe "ActiveRecord Validations" do
    it { should have_many(:accounts) }
    it { should accept_nested_attributes_for(:accounts).allow_destroy(true) }
  end
end
