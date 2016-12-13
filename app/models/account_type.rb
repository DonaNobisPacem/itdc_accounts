class AccountType < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  include PublicActivity::Common
end
