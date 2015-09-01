class Habit < ActiveRecord::Base
  has_many :milestones
  has_many :users, through: :milestones

end
