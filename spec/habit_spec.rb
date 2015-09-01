require('spec_helper')

describe(Habit) do
  it { should have_and_belong_to_many(:users) }
end
