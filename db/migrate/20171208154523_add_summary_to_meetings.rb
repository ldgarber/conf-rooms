class AddSummaryToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :meetings, :summary, :string
  end
end
