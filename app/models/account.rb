class Account < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  validates :account_type, presence: true
  validates :beginning_amount, numericality: { :greater_than_or_equal_to => 0 }
  validates :balance, numericality: true

  after_create :set_balance

  def set_balance
    self.balance = self.beginning_amount
  end
end
