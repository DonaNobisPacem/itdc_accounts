require 'rails_helper'

RSpec.describe "account_transactions/show", type: :view do
  before(:each) do
    @account_transaction = assign(:account_transaction, AccountTransaction.create!(
      :transaction_type => 2,
      :amount => "9.99",
      :prev_balance => "9.99",
      :new_balance => "9.99",
      :description => "MyText",
      :account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
