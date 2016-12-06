module ReportsHelper
  def account_last_update(account)
    if account.account_transactions.present?
      return account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M")
    else
      return "No Transactions Found"
    end
  end
end
