module UsersHelper
  def render_accounts
    if @accounts.empty?
      render "shared/no_entries"
    else
      render "accounts/accounts_table"
    end
  end
end
