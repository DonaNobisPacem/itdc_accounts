require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :account_type => 2,
        :beginning_amount => "9.99",
        :balance => "9.99",
        :user => nil
      ),
      Account.create!(
        :account_type => 2,
        :beginning_amount => "9.99",
        :balance => "9.99",
        :user => nil
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
