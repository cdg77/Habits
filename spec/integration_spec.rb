require 'spec_helper'
require 'capybara/rspec'
require './app'

describe '/', {:type => :feature} do
  it 'loads the index page' do
    visit '/'
    expect(page).to have_content("Habits.com “Your beliefs become your thoughts, Your thoughts become your words, Your words become your actions, Your actions become your habits, Your habits become your values, Your values become your destiny.” Form A Habit Add A User")
  end

  it 'goes to form habit page' do
    visit '/'
    click_link 'Form A Habit'
    expect(page).to have_content ('Create A New Habit')
  end

  it 'goes to user add' do
    visit '/'
    click_link 'Add A User'
    expect(page).to have_content ('Create A New User')
  end
  it 'creates a new user' do
    visit '/user_add'
    fill_in 'name', :with => "Smokey"
    fill_in 'age', :with => "10"
    fill_in 'location', :with => "Portland"
    fill_in 'email', :with => "smoker@chmorris.com"
    fill_in 'phone', :with => "555-555-5555"
    select 'Yes', :from => 'contact'
    click_button 'CreateUser'
    expect(page).to have_content ('')

  end
end
