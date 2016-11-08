require 'rails_helper'

RSpec.describe "account_types/show", type: :view do
  before(:each) do
    @account_type = assign(:account_type, AccountType.create!(
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
