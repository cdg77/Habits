class User < ActiveRecord::Base

  has_many :milestones
  has_many :habits, through: :milestones
  validates(:name, {:presence => true, :length => { minimum: 1 }})
  before_save(:capitalize_user)

private

  def capitalize_user
    self.name=(name.titleize)
  end

end
