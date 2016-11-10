module UsersHelper
  def render_accounts
    if @accounts.empty?
      render "shared/no_entries"
    else
      render "accounts/accounts_table"
    end
  end

  def render_edit
    if current_user.admin?
      #admin version edit
      link_to 'Edit this Account', edit_user_path
    elsif current_user.id == @user.id
      #regular version edit
      link_to 'Edit My Account', edit_user_registration_path
    else
      #no edit link
    end
  end
end
