require 'spec_helper'
require 'capybara/rspec'
require './app'

describe '/' do
  it 'loads the index page' do
    visit '/'
    expect(page).to have_content(" Your beliefs become your thoughts,
    Your thoughts become your words,
    Your words become your actions,
    Your actions become your habits,
    Your habits become your values,
    Your values become your destiny. Add A Habit Break a Habit")
  end

  it 'goes to form habit page' do
    visit '/'
    click_link 'Add A Habit'
    expect(page).to have_content ('Form A Habit')
  end

  it 'goes to break habit page' do
    visit '/'
    click_link 'Break A Habit'
    expect(page).to have_content ('Break A Habit')
  end
end
