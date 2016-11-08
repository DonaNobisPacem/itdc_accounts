class AccountTransaction < ActiveRecord::Base
  belongs_to :account
  validates :account, presence: true

  validates :transaction_type, presence: true
  validates :amount, numericality: { :greater_than_or_equal_to => 0 }
  validates :prev_balance, numericality: true
  validates :new_balance, numericality: true

  after_create :set_computed_balance

  def set_computed_balance
    #set previous balance
    self.prev_balance = self.account.balance

    #set new balance
    if self.transaction_type == 1 # credit
      self.new_balance = self.account.balance + self.amount
    elsif self.transaction_type == 2 # debit
      self.new_balance = self.account.balance - self.amount
    else
    end

    #set balance on parent account
    @account = self.account
    @account.balance = self.new_balance
    @account.save
  end
end
