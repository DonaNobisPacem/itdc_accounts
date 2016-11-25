class AddDefaultValueToAnnouncementVisibility < ActiveRecord::Migration
  def change
    change_column :announcements, :visible_to_users, :boolean, default: false
    change_column :announcements, :visible_to_admins, :boolean, default: false
  end
end
