require 'rails_helper'

RSpec.describe "account_types/edit", type: :view do
  before(:each) do
    @account_type = assign(:account_type, AccountType.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit account_type form" do
    render

    assert_select "form[action=?][method=?]", account_type_path(@account_type), "post" do

      assert_select "input#account_type_title[name=?]", "account_type[title]"

      assert_select "textarea#account_type_description[name=?]", "account_type[description]"
    end
  end
end
