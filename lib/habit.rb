class Habit < ActiveRecord::Base
  has_many :milestones
  has_many :users, through: :milestones
  validates(:name, {:presence => true, :length => { minimum: 1 }})
  before_save(:capitalize_habit)

private

  def capitalize_habit
    self.name=(name.titleize)
  end
  
end
