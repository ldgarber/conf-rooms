class AddDateToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :meetings, :date, :date
  end
end
