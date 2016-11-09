module UsersHelper
  def render_accounts
    if @accounts.empty?
      render "shared/no_entries"
    else
      render "accounts_table"
    end
  end
end
