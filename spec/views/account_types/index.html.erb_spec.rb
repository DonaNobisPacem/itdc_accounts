require 'rails_helper'

RSpec.describe "account_types/index", type: :view do
  before(:each) do
    assign(:account_types, [
      AccountType.create!(
        :title => "Title",
        :description => "MyText"
      ),
      AccountType.create!(
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of account_types" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
