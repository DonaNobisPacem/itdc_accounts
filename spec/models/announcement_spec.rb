require 'rails_helper'

RSpec.describe Announcement, type: :model do
  it "has a valid factory" do
    expect( FactoryGirl.build(:announcement) ).to be_valid 
  end

  describe "ActiveModel Validations" do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:start_date) }
  end
end
