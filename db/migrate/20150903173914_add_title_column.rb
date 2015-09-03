class AddTitleColumn < ActiveRecord::Migration
  def change
    add_column(:messageboards, :title, :string)
  end
end
