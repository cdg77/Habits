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

post '/new_user' do
  name = params.fetch('name')
  age = params.fetch('age')
  location = params.fetch('location')
  email = params.fetch('email')
  phone = params.fetch('phone')
  contact = params.fetch('contact')
  @user = User.create({:name => name, age: age, location: location, email: email, phone: phone, contact: contact})

  erb :user

  end

post '/new_user' do
  "Hello World"
end
