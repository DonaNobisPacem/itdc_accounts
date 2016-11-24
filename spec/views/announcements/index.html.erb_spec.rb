require 'rails_helper'

RSpec.describe "announcements/index", type: :view do
  before(:each) do
    assign(:announcements, [
      Announcement.create!(
        :subject => "Subject",
        :message => "MyText",
        :visible_to_users => false,
        :visible_to_admins => false
      ),
      Announcement.create!(
        :subject => "Subject",
        :message => "MyText",
        :visible_to_users => false,
        :visible_to_admins => false
      )
    ])
  end

  it "renders a list of announcements" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
