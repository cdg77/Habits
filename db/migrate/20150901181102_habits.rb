class Habits < ActiveRecord::Migration
  def change
    create_table(:habits) do |t|
      t.column(:name, :string)
      t.column(:description, :string)
      t.column(:comepletion_steps, :string)
      t.column(:form, :boolean)



      t.timestamps()
    end
  end
end
