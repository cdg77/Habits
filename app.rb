require("bundler/setup")
Bundler.require(:default)
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end


##### HABITS #####

get '/habits' do
  @habits = Habit.all
  erb :habits
end

get '/form_habits' do
  @habits = Habit.all()

  erb :habit_form
end

get '/habit_form' do

  erb :habit_form
end

get '/habits/new' do

  erb :habit_form
end

post '/habits/new' do
  form = params.fetch('form')
  name = params.fetch('habit_name')
  @habit = Habit.create({:name => name, form: form})
  if @habit.save
    @habits = Habit.all
    erb :habits
  else
    erb :habit_validation_fail
  end
end

get '/habits/:id' do
  id = params.fetch('id').to_i
  @habit = Habit.find(id)
  @users = User.all()
  erb :habit_detail

end

post '/habits/:id/' do
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  erb :habit_detail
end

post '/habits/:id/users/new' do
  habit_id = params.fetch('id').to_i
  user_id = params.fetch('user_id').to_i
  habit = Habit.find(habit_id)
  user = User.find(user_id)
  habit.users.push(user)
  @habits = Habit.all
  @users = User.all()
  erb :habits

end

patch '/habits/:id/update' do
  id = params.fetch('id')
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  @habit.update({name: name, article: article})
  redirect "/habits/#{@habit.id}"

end


delete '/habits/:id/delete' do
  id = params.fetch('id')
  habit = Habit.find(id)
  habit.destroy
  @habits = Habit.all
  erb :habits

end


##### USERS #####

get '/users' do
  @users = User.all
  erb :users
end


get '/user_add' do
  erb :user_add
end

get '/user/new' do

  erb :user_add

end

get '/user/:id' do
  id = params.fetch('id')
  @user = User.find(id)
  @habits = Habit.all
  erb :user_detail
end

post '/users/:id/habits/new' do
  habit_id = params.fetch('id').to_i
  user_id = params.fetch('user_id').to_i
  habit = Habit.find(habit_id)
  user = User.find(user_id)
  habit.users.push(user)
  @habits = Habit.all
  @users = User.all()
  erb :habits

end


post '/new_user' do
  name = params.fetch('name')
  age = params.fetch('age')
  location = params.fetch('location')
  email = params.fetch('email')
  phone = params.fetch('phone')
  contact = params.fetch('contact')
  @user = User.create({:name => name, age: age, location: location, email: email, phone: phone, contact: contact})
  if @user.save
    @users = User.all
    erb :user_detail
  else
    erb :user_validation_fail
  end
end


patch '/users/:id/update' do
  id = params.fetch('id')
  @user = User.find(id)
  name = params.fetch('name', @user.name)
  age = params.fetch('age', @user.age)
  location = params.fetch('location', @user.location)
  email = params.fetch('email', @user.email)
  phone = params.fetch('phone', @user.phone)
  contact = params.fetch('contact', @user.contact)
  @user.update({name: name, age: age, location: location, email: email, phone: phone, contact: contact})
  redirect "/user/#{@user.id}"
end

delete '/users/:id/delete' do
  id = params.fetch('id')
  user = User.find(id)
  user.destroy
  @users = User.all()
  erb :users
end
