require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end

get '/form_habits' do
  @habits = Habit.all()

  erb :habit_form
end

get '/user_add' do

  erb :user_add
end

get '/habit_form' do

  erb :habit_form
end

post '/habits/new/create' do
  habit_name = params.fetch('habit_name')
  age = params.fetch('age')
  city_name = params.fetch('city_name')
  email = params.fetch('email')
  phone_number = params.fetch('phone_number')
  contact = params.fetch('contact')
  @habit = Habit.create({:name => habit_name, age: age, city_name: city_name, email: email, phone_number: phone_number, contact: contact})

  erb :habits

  end
