class Milestones < ActiveRecord::Migration
  def change
    create_table(:milestones) do |t|
      t.column(:habit_id, :int)
      t.column(:user_id, :int)
      t.column(:milestone, :datetime)
      t.column(:date_created, :timestamp)
    end
  end
end
