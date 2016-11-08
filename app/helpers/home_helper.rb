module HomeHelper
  def render_homepage
    if current_user.admin
      render 'admin'
    else
      render 'user'
    end
  end
end
