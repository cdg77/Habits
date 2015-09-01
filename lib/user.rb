class User < ActiveRecord::Base
  has_many :milestones
  has_many :habits, through: :milestones
end
