require 'rails_helper'

RSpec.describe "transaction_types/show", type: :view do
  before(:each) do
    @transaction_type = assign(:transaction_type, TransactionType.create!(
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
