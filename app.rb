require("bundler/setup")
Bundler.require(:default)
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end

get '/form_habits' do
  @habits = Habit.all()

  erb :habit_form
end

get '/habit_form' do

  erb :habit_form
end

get '/user_add' do

  erb :user_add
end

post '/new_user' do
  name = params.fetch('name')
  age = params.fetch('age')
  location = params.fetch('location')
  email = params.fetch('email')
  phone = params.fetch('phone')
  contact = params.fetch('contact')
  @user = User.create({:name => name, age: age, location: location, email: email, phone: phone, contact: contact})

  erb :user_detail
end

post '/habits/new' do
  form = params.fetch('form')
  name = params.fetch('habit_name')
  @habit = Habit.create({:name => name, form: form})
  @habits = Habit.all
  erb :habits
end

get '/habits/:id' do
  id = params.fetch('id').to_i
  @habit = Habit.find(id)
  erb :habit_detail

end

post '/habits/:id/' do
  #cant find id.
  # id = params.fetch('id')
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  erb :habit_detail
end

patch '/habits/:id/update' do
  id = params.fetch('id')
  binding.pry
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  @habit.update({name: name, article: article})
  redirect "/habits/#{@habit.id}"

end
