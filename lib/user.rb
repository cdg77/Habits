class User < ActiveRecord::Base
  has_many :habits, through: :milestones
end
