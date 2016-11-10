module AccountsHelper
  def render_transactions
    if @account_transactions.empty?
      render "shared/no_entries"
    else
      render "account_transactions/transactions_table"
    end
  end
end
