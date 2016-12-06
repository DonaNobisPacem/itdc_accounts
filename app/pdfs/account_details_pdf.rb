class AccountDetailsPdf < BasePdf
  #TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = [["Date", "Credit", "Debit", "Balance"]]

  def initialize(account=[])
    super()
    @account = account

    header 'Account Details' + " - " + @account.account_type_desc, @account.owner_name 
    move_down 20
    text 'Beginning Amount: ' + ntc(@account.beginning_amount), size: 12
    text 'Current Balance: ' + ntc(@account.balance), size: 12
    move_down 20
    display_event_table
    footer
  end

  private

  def display_event_table
    if table_data.empty?
      text "No Transactions Found"
    else
      table table_data do
        self.header = true
        self.width = 540
        row(0).font_style = :bold
        #row(0).background_color = '373a3c'
        #row(0).text_color = "FFFFFF"
        row(-1).font_style = :bold
        #row(-1).background_color = '373a3c'
        #row(-1).text_color = "FFFFFF"
        columns(1..3).align = :right
        row(0).columns(0..3).align = :center
      end
    end
  end

  def table_data
    @account_transactions = @account.account_transactions.order(created_at: :asc)
    data = @account_transactions.map do |a|
      if a.transaction_type == 1
        [a.created_at.localtime.strftime("%^b-%d-%Y %H:%M"), ntc(a.amount), "", ntc(a.new_balance)]
      elsif a.transaction_type == 2
        [a.created_at.localtime.strftime("%^b-%d-%Y %H:%M"), "", ntc(a.amount), ntc(a.new_balance)]
      else
        ["Something went wrong.","", "", ""]
      end
    end
    TABLE_HEADERS + data + [["TOTALS:", ntc(@account.total_credit), ntc(@account.total_debit), ""]]
  end

  def account_last_update(account)
    if account.account_transactions.present?
      return account.account_transactions.last.transaction_type_desc + ": " + account.account_transactions.last.created_at.localtime.strftime("%^b-%d-%Y %H:%M")
    else
      return "No Transactions Found"
    end
  end
end