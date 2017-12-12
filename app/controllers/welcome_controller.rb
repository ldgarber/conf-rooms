class WelcomeController < ApplicationController

  def index
    @meetings = Meeting.all
    @rooms = Room.all
  end

  def display
    @rooms = Room.all
  end

end

