class SummaryOfAccountsPdf < BasePdf
  #TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = [["User", "Beginnning Amount", "Credits", "Debits", "Balance", "Last Update"]]

  def initialize(accounts=[])
    super()
    @accounts = accounts

    header 'Summary of Accounts', @accounts.first.account_type_desc
    move_down 20
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "No Accounts Found"
    else
      table table_data do
        self.header = true
        row(0).font_style = :bold
        #row(0).background_color = '373a3c'
        #row(0).text_color = "FFFFFF"
        row(-1).font_style = :bold
        #row(-1).background_color = '373a3c'
        #row(-1).text_color = "FFFFFF"
        columns(1..4).align = :right
        row(0).columns(0..5).align = :center
      end
    end
  end

  def table_data
    TABLE_HEADERS + 
    @accounts.map { |a| [a.owner_name, ntc(a.beginning_amount), ntc(a.total_credit), ntc(a.total_debit), ntc(a.balance), account_last_update(a)] } + 
    [["TOTALS:", ntc(@accounts.sum(:beginning_amount)), ntc(@accounts.to_a.sum(&:total_credit)), ntc(@accounts.to_a.sum(&:total_debit)), ntc(@accounts.sum(:balance)), Time.now.strftime("%^b-%d-%Y %H:%M")]]
  end

  def account_last_update(account)
    if account.account_transactions.present?
      return account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M")
    else
      return "No Transactions Found"
    end
  end
end