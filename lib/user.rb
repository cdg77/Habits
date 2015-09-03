class User < ActiveRecord::Base

  has_many :milestones
  has_many :habits, through: :milestones
  validates(:name, {:presence => true, :length => { minimum: 1 }})
  before_save(:capitalize_user)
  #sessions stuff
  validates_uniqueness_of :email
  validates(:password, {:presence => true, :length => {:minimum => 5, :maximum => 25}})
  
private

  def capitalize_user
    self.name=(name.titleize)
  end

end
