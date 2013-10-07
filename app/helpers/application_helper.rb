module ApplicationHelper
  
  def can_display_status?(status)
    (signed_in? && !current_user.has_blocked?(status.user)) || !signed_in?
  end

  def flash_class(type)
    case type
      when :error
        "alert-danger"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        "#{type}"
    end
  end

end
