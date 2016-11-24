module AnnouncementsHelper
  def render_announcements
    if @announcements.empty?
      render "shared/no_entries"
    else
      if current_user.admin?
        render "announcements_table_admin"
      else
        render "announcements_table_user"
      end
    end
  end

  def announcement_visibility(announcement)
    s = ""
    announcement.visible_to_users ? s += "Users=Yes | " : s += "Users=No | "
    announcement.visible_to_admins ? s += "Admins=Yes" : s += "Admins=No"
    s
  end

  def render_announcements_show
    if current_user.admin?
      render "show_admin"
    else
      render "show_user"
    end
  end
end
