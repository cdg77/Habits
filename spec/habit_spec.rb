require('spec_helper')

describe(Habit) do
  it {have_many :users, through: :milestones }
end
