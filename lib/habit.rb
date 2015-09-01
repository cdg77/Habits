class Habit < ActiveRecord::Base
  has_many :users, through: :milestones

end
