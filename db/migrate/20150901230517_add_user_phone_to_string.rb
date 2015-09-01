class AddUserPhoneToString < ActiveRecord::Migration
  def change
    remove_column(:users, :phone, :int)
      add_column(:users, :phone, :string)

  end
end
