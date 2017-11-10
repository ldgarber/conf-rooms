class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validate :room_cannot_be_booked_for_that_time, :on => :create

  def start 
    convert_time(self.start_time)
  end

  def end
    convert_time(self.end_time)
  end

  def convert_time(datetime)
    est_time = datetime.in_time_zone("Eastern Time (US & Canada)")
    return est_time.strftime("%I:%M%p")
  end

  def room_cannot_be_booked_for_that_time
    mtgs = Meeting.meetings_in_room(room_id)
    filtered = overlapping_meetings(start_time, end_time, mtgs)
    if (filtered.length > 0) 
      errors.add(:room_id, "is already booked in this time range") 
    end
  end

  def updated_room_cannot_be_booked
    mtgs = Meeting.meetings_in_room(room_id)
    filtered = overlapping_meetings(start_time, end_time, mtgs)
    remove_self = remove_self(id, filtered)
    if (filtered.length > 0) 
      errors.add(:room_id, "is already booked in this range") 
    end
  end

  def overlapping_meetings(start_date, end_date, meetings) 
    #returns array of meetings where the start_date or end_date overlap
    result = []
    meetings.each do |meeting| 
      if start_date.between?(meeting.start_time, meeting.end_time) 
        result << meeting
      elsif end_date.between?(meeting.start_time, meeting.end_time)
        result << meeting
      elsif meeting.start_time.between?(start_date, end_date)
        result << meeting
      elsif meeting.end_time.between?(start_date, end_date)
        result << meeting 
      end
    end
    return result
  end

  def time_range
    (self.start_time...self.end_time) 
  end

  #returns array of meetings that belong to specified id  
  def self.meetings_in_room(room_id)
    Meeting.all.select{ |meeting| meeting.room_id == room_id }
  end

end
