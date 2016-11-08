require 'rails_helper'

RSpec.describe "account_transactions/edit", type: :view do
  before(:each) do
    @account_transaction = assign(:account_transaction, AccountTransaction.create!(
      :transaction_type => 1,
      :amount => "9.99",
      :prev_balance => "9.99",
      :new_balance => "9.99",
      :description => "MyText",
      :account => nil
    ))
  end

  it "renders the edit account_transaction form" do
    render

    assert_select "form[action=?][method=?]", account_transaction_path(@account_transaction), "post" do

      assert_select "input#account_transaction_transaction_type[name=?]", "account_transaction[transaction_type]"

      assert_select "input#account_transaction_amount[name=?]", "account_transaction[amount]"

      assert_select "input#account_transaction_prev_balance[name=?]", "account_transaction[prev_balance]"

      assert_select "input#account_transaction_new_balance[name=?]", "account_transaction[new_balance]"

      assert_select "textarea#account_transaction_description[name=?]", "account_transaction[description]"

      assert_select "input#account_transaction_account_id[name=?]", "account_transaction[account_id]"
    end
  end
end
