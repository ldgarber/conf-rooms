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
      errors.add(:room_id, "is already booked in this date range") 
    end
  end

  def updated_room_cannot_be_booked
    mtgs = Meeting.meetings_in_room(room_id)
    filtered = overlapping_meetings(start_time, end_time, mtgs)
    remove_self = remove_self(id, filtered)
    if (filtered.length > 0) 
      errors.add(:room_id, "is already booked in this date range") 
    end
  end

  def overlapping_meetings(start_date, end_date, meetings) 
    meetings.collect { |meeting|  
      (start_date...end_date).overlaps?(meeting.time_range) 
    } 
  end

  def time_range
    (self.start_time...self.end_time) 
  end

  #returns array of meetings that belong to specified id  
  def self.meetings_in_room(room_id)
    Meeting.all.select{ |meeting| meeting.room_id == room_id }
  end
end
