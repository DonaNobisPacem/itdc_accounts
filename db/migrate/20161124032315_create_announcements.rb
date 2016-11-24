class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :subject
      t.text :message
      t.boolean :visible_to_users
      t.boolean :visible_to_admins
      t.datetime :start_date

      t.timestamps null: false
    end
  end
end
