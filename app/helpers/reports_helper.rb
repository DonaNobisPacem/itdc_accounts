module ReportsHelper
  def account_user_name_or_email(account)
    if account.user.first_name.present? && account.user.last_name.present?
      return account.user.last_name + ", " + account.user.first_name
    else
      return account.user.email
    end
  end

  def account_last_update(account)
    if account.account_transactions.present?
      return account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M")
    else
      return "No Transactions Found"
    end
  end
end
