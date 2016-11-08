require 'rails_helper'

RSpec.describe "account_transactions/index", type: :view do
  before(:each) do
    assign(:account_transactions, [
      AccountTransaction.create!(
        :transaction_type => 2,
        :amount => "9.99",
        :prev_balance => "9.99",
        :new_balance => "9.99",
        :description => "MyText",
        :account => nil
      ),
      AccountTransaction.create!(
        :transaction_type => 2,
        :amount => "9.99",
        :prev_balance => "9.99",
        :new_balance => "9.99",
        :description => "MyText",
        :account => nil
      )
    ])
  end

  it "renders a list of account_transactions" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
