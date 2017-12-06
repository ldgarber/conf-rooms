require "spec_helper"

describe Meeting, ".meetings_in_room" do
  it "returns only meetings in the room" do 
    #setup
    in_room = create(:meeting, room_id: 1)
    not_in_room = create(:meeting, room_id: 2)

    result = Meeting.meetings_in_room(1)
    expect(result).to eq [in_room]
  end

  it "returns all meetings in the room" do 
    #setup
    in_room = create(:meeting, room_id: 1)
    also_in_room = create(:meeting, room_id: 1)

    result = Meeting.meetings_in_room(1)
    expect(result).to eq [in_room, also_in_room]
  end
end
