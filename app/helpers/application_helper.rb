module ApplicationHelper
  def flash_class(key)
    case key
      when :notice 
        return "info"
      when :success
        return "success"
      when :error 
        return "danger"
      when :alert 
        return "warning"
      else 
        return "lalalalal"
    end
  end
end
