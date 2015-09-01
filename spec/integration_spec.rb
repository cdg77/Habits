require 'spec_helper'
require 'capybara/rspec'
require './app'

describe '/', {:type => :feature} do
  it 'loads the index page' do
    visit '/'
    expect(page).to have_content("Habits.com “Your beliefs become your thoughts, Your thoughts become your words, Your words become your actions, Your actions become your habits, Your habits become your values, Your values become your destiny.” Form A Habit Break A Habit")
  end

  it 'goes to form habit page' do
    visit '/'
    click_link 'Form A Habit'
    expect(page).to have_content ('Create A New Habit')
  end

  it 'goes to break habit page' do
    visit '/'
    click_link 'Break A Habit'
    expect(page).to have_content ('Break An Old Habit')
  end
end
