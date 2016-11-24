module HomeHelper
  def render_homepage
    if current_user.admin
      render 'admin'
    else
      render 'user'
    end
  end

  def render_home_announcements
    if @announcements.empty?
      render "shared/no_entries"
    else
      render "announcements_table"
    end
  end
end
