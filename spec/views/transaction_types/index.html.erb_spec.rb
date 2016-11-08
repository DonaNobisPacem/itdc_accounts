require 'rails_helper'

RSpec.describe "transaction_types/index", type: :view do
  before(:each) do
    assign(:transaction_types, [
      TransactionType.create!(
        :title => "Title",
        :description => "MyText"
      ),
      TransactionType.create!(
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of transaction_types" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
