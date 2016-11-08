require 'rails_helper'

RSpec.describe "transaction_types/edit", type: :view do
  before(:each) do
    @transaction_type = assign(:transaction_type, TransactionType.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit transaction_type form" do
    render

    assert_select "form[action=?][method=?]", transaction_type_path(@transaction_type), "post" do

      assert_select "input#transaction_type_title[name=?]", "transaction_type[title]"

      assert_select "textarea#transaction_type_description[name=?]", "transaction_type[description]"
    end
  end
end
