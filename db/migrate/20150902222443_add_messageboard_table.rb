class AddMessageboardTable < ActiveRecord::Migration
  def change
    create_table(:messageboards) do |t|
      t.column(:message, :string)
      t.column(:habit_id, :integer)
      t.timestamps()
  end
end
