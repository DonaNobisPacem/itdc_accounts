json.extract! announcement, :id, :subject, :message, :visible_to_users, :visible_to_admins, :start_date, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)