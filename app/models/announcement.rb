class Announcement < ActiveRecord::Base
  validates :subject, presence: true
  validates :message, presence: true
  validates :start_date, presence: true
  include PublicActivity::Common
end
