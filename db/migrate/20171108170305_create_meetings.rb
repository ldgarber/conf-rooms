class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
