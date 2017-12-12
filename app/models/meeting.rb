class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_presence_of :start_time, :end_time
  validate :room_cannot_be_booked_for_that_time
  validate :end_time_is_later_than_start_time

  before_create :set_summary

  TODAYS_DATE = Time.now.in_time_zone("UTC").to_date
  
  def start 
    convert_time(self.start_time)
  end

  def end
    convert_time(self.end_time)
  end

  def set_summary
    self.summary = "untitled" if summary.blank?
  end

  def convert_time(datetime)
    est_time = datetime.in_time_zone("Eastern Time (US & Canada)")
    return est_time.strftime("%I:%M%p")
  end

  def end_time_is_later_than_start_time
    if !(end_time > start_time) 
      errors.add(:end_time, "must be later than start time")
    end
  end

  def room_cannot_be_booked_for_that_time
    mtgs = Meeting.in_room(room_id)
    mtgs = remove_self(mtgs)
    errors.add(:room_id, "is already booked in this time range")  if any_overlapping_meetings?(mtgs)
  end

  def any_overlapping_meetings?(mtgs)
    overlapping_meetings(mtgs).length > 0
  end

  def overlapping_meetings(meetings) 
    #returns array of meetings where the start_date or end_date overlap
    meetings.select do |meeting| 
      meeting_overlaps?(self.start_time, self.end_time, meeting.start_time, meeting.end_time)
    end
  end

  def meeting_overlaps?(s1, e1, s2, e2)
    return (s1 < e2) && (e1 > s2) 
  end

  def remove_self(meetings)
    meetings.reject {|meeting| meeting.id == self.id}
  end

  def date_range 
  end 

  def start_date
    start_time.to_date
  end

  def end_date
    end_time.to_date
  end

  #returns array of meetings that belong to specified id  
  def self.in_room(room_id)
    Meeting.all.select{ |meeting| (meeting.room_id == room_id) }
  end


  def self.starting_on(date)
    Meeting.where("DATE(start_time) = ?", date)
  end

  def self.starting_today
    Meeting.starting_on(TODAYS_DATE)
  end
end
