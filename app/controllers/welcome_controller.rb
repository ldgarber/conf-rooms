class WelcomeController < ApplicationController

  def index
    @meetings = Meeting.all
    @rooms = Room.all
    @meetings_today = Meeting.starting_today
  end

end

