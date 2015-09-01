require('spec_helper')

describe(User) do
  it {have_many :habits, through: :milestones }
end
