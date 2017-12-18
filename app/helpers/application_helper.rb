module ApplicationHelper
  TODAYS_DATE = Time.now.in_time_zone("UTC").to_date
 
  def bootstrap_class_for(flash_type)
    { success: "success", error: "danger", alert: "warning", notice: "info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message| 
      concat(content_tag(:div, message, class: "alert alert-#{bootstrap_class_for(msg_type)} fade in widget-inner") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' }) 
              concat message
            end)
    end
    nil
  end

  def meeting_in_room(meeting, room)
    return meeting.room_id = room.id
  end

  def any_meetings_today? 
    !Meeting.starting_today.empty?
  end

end
