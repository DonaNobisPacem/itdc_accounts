class SummaryOfAccountsPdf < BasePdf
  #TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = [["User", "Beginnning Amount", "Credits", "Debits", "Balance", "Last Update"]]

  def initialize(accounts=[])
    super()
    @accounts = accounts

    header 'Summary of Accounts Report'
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "No Accounts Found"
    else
      table table_data,
        header: true
        #row(0).font_style = :bold
        #header: TABLE_HEADERS
        #column_widths: TABLE_WIDTHS,
        #row_colors: TABLE_ROW_COLORS,
        #font_size: TABLE_FONT_SIZE
    end
  end

  def table_data
    @table_data = TABLE_HEADERS
    @table_data += @accounts.map { |a| [a.owner_name, a.beginning_amount, a.total_credit, a.total_debit, a.balance, account_last_update(a)] }
  end

  def account_last_update(account)
    if account.account_transactions.present?
      return account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M")
    else
      return "No Transactions Found"
    end
  end
end