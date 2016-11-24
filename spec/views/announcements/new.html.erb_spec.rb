require 'rails_helper'

RSpec.describe "announcements/new", type: :view do
  before(:each) do
    assign(:announcement, Announcement.new(
      :subject => "MyString",
      :message => "MyText",
      :visible_to_users => false,
      :visible_to_admins => false
    ))
  end

  it "renders new announcement form" do
    render

    assert_select "form[action=?][method=?]", announcements_path, "post" do

      assert_select "input#announcement_subject[name=?]", "announcement[subject]"

      assert_select "textarea#announcement_message[name=?]", "announcement[message]"

      assert_select "input#announcement_visible_to_users[name=?]", "announcement[visible_to_users]"

      assert_select "input#announcement_visible_to_admins[name=?]", "announcement[visible_to_admins]"
    end
  end
end
