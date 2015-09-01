class Habit < ActiveRecord::Base
  has_many_through(:users)


end
