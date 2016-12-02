module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert alert-success"   # Green
      when "error"
        "alert alert-danger"    # Red
      when "alert"
        "alert alert-warning"   # Yellow
      when "notice"
        "alert alert-info"      # Blue
      else
        flash_type.to_s
    end
  end
end
