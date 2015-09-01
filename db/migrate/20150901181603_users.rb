class Users < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.column(:name, :string)
      t.column(:age, :int)
      t.column(:location, :string)
      t.column(:email, :string)
      t.column(:phone, :int)
      t.column(:contact, :boolean)




      t.timestamp()
    end
  end
end
