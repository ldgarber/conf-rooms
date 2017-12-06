class MeetingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy ]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @meetings = Meeting.all
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to root_path, flash: {success: 'Meeting was successfully created.'} }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { redirect_to new_meeting_path, flash: {danger: "Unable to create meeting. " + @meeting.errors.full_messages.join('. ')} }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to root_path, flash: {success: 'Meeting was successfully updated.'} } 
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { redirect_to edit_meeting_path, flash: {danger: "Unable to edit meeting. " + @meeting.errors.full_messages.join('. ')} }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to root_path, flash: {success:'Meeting was successfully removed.'} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:user_id, :room_id, :start_time, :end_time, :date)
    end

    def require_permission 
      if current_user != Meeting.find(params[:id]).user 
        flash[:danger] = "You can't update a meeting you didn't book."
        redirect_to root_path
      end
    end
end
