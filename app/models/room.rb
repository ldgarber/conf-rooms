class Room < ApplicationRecord
  has_many :meetings

  TODAYS_DATE = Time.now.in_time_zone("UTC").to_date

  def todays_meetings
    self.meetings_on_date(TODAYS_DATE)
  end

  def meetings_on_date(date)
    meetings.select {|meeting| meeting.start_date == date}
  end

end
