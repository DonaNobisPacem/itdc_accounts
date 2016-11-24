require 'rails_helper'

RSpec.describe "announcements/show", type: :view do
  before(:each) do
    @announcement = assign(:announcement, Announcement.create!(
      :subject => "Subject",
      :message => "MyText",
      :visible_to_users => false,
      :visible_to_admins => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
