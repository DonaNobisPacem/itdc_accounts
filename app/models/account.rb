class Account < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  validates :account_type, presence: true
  validates :beginning_amount, numericality: { :greater_than_or_equal_to => 0 }
  # validates :balance, numericality: true

  has_many :account_transactions, dependent: :destroy
  accepts_nested_attributes_for :account_transactions, allow_destroy: true

  before_create :set_balance
  include PublicActivity::Common

  def set_balance
    self.balance = self.beginning_amount
  end

  def total_credit
    account_transactions.where(transaction_type: 1).sum(:amount)
  end

  def total_debit
    account_transactions.where(transaction_type: 2).sum(:amount)
  end

  def account_type_desc
    AccountType.where(id: account_type).first.title
  end

  def owner_name
    u = user
    n = ""
    if u.first_name.present? && u.last_name.present?
      n = u.last_name + ", " + u.first_name
    else
      n = u.email
    end
    n
  end

  def accd_to_csv
    CSV.generate do |csv|
      csv << ['Owner Name', 'Email', 'Account Type', 'Beginning Amount', 'Balance']
      csv << [owner_name, user.email, account_type_desc, beginning_amount, balance]
      csv << ['Date', 'Credit', 'Debit', 'Balance']
      account_transactions.each do |transaction|
        if transaction.transaction_type == 1
          csv << [transaction.created_at.localtime.strftime("%^b-%d-%Y %H:%M"), transaction.amount, '', transaction.new_balance]
        elsif transaction.transaction_type == 2
          csv << [transaction.created_at.localtime.strftime("%^b-%d-%Y %H:%M"), '',transaction.amount, transaction.new_balance]
        else
        end
      end
      csv << ['TOTALS:', total_credit, total_debit, balance]
    end
  end

  def self.to_csv(records = [], options = {})
    CSV.generate(options) do |csv|
      csv << ['Users', 'Beginning Amount', 'Credits', 'Debits', 'Balance', 'Last Update']
      records.each do |account|
        account_last_update = account.account_transactions.present? ? account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M") : "No Transactions Found."
        csv << [account.owner_name, account.beginning_amount, account.total_credit, account.total_debit, account.balance, account_last_update]
      end
      csv << ['TOTALS:', records.sum(:beginning_amount), records.to_a.sum(&:total_credit), records.to_a.sum(&:total_debit), records.sum(:balance), Time.now.strftime("%^b-%d-%Y-%H-%M")]
    end
  end
end
