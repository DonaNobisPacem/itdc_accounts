require 'rails_helper'

RSpec.describe "transaction_types/new", type: :view do
  before(:each) do
    assign(:transaction_type, TransactionType.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new transaction_type form" do
    render

    assert_select "form[action=?][method=?]", transaction_types_path, "post" do

      assert_select "input#transaction_type_title[name=?]", "transaction_type[title]"

      assert_select "textarea#transaction_type_description[name=?]", "transaction_type[description]"
    end
  end
end
