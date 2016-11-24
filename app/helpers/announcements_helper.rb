module AnnouncementsHelper
  def render_announcements
    if @announcements.empty?
      render "shared/no_entries"
    else
      render "announcements_table"
    end
  end

  def announcement_visibility(announcement)
    s = ""
    announcement.visible_to_users ? s += "Users=Yes | " : s += "Users=No | "
    announcement.visible_to_admins ? s += "Admins=Yes" : s += "Admins=No"
    s
  end

  def render_announcements_index
    if current_user.admin?
      render "index_admin"
    else
      render "index_user"
    end
  end

  def render_announcements_show
    if current_user.admin?
      render "show_admin"
    else
      render "show_user"
    end
  end
end
