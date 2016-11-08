require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      :account_type => 1,
      :beginning_amount => "9.99",
      :balance => "9.99",
      :user => nil
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_account_type[name=?]", "account[account_type]"

      assert_select "input#account_beginning_amount[name=?]", "account[beginning_amount]"

      assert_select "input#account_balance[name=?]", "account[balance]"

      assert_select "input#account_user_id[name=?]", "account[user_id]"
    end
  end
end
