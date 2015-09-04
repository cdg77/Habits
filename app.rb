require("bundler/setup")
Bundler.require(:default)
require 'sinatra/base'
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



#Session section for user login system
#ActiveRecord::Base.establish_connection(ENV['postgres: //yhzvzhitpdddjb:OUoMXJ6gA-Zbt2mfhESmqYUZbb@ec2-54-163-227-94.compute-1.amazonaws.com:5432/df8du51q5u3j7t'])

enable :sessions

helpers do

  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:username]
  end

end



get '/' do
  erb :index
end


##### Sessions #####

post '/signup' do
  name = params.fetch('name')
  email = params.fetch('email')
  password = params.fetch('password')
  age = params.fetch('age')
  location = params.fetch('location')
  phone = params.fetch('phone')
  contact = params.fetch('contact')
  password_confirmation = params.fetch('password_confirmation')
  if password != password_confirmation
    redirect '/signup_error'
  end

  @user = User.create({name: name, email: email, password: password, age: age, location: location, phone: phone, contact: contact})
  if @user.save
    redirect "/users"
  else
    redirect '/signup_error'
  end
end


post '/login' do
  email = params.fetch('email')
  password = params.fetch('password')
  @@current_user = nil
  User.all.each do |user|
    if user.email == email && user.password == password
      @user = user
      @@current_user = @user
    end
  end
  session[:username] = @@current_user
  if @@current_user != nil
    redirect("/user/#{@@current_user.id}")
  else
    erb :signup_error
  end
end

get '/logout' do
  session[:username] = nil
  redirect '/'
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
  @habits = Habit.all()
  @messageboards = @habit.messageboards
  # @messageboards = Messageboard.find_by(habit_id: id)
  # binding.pry
  erb :habit_detail
end

post '/habits/:id/' do
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  id = params.fetch('id').to_i
  @habit = Habit.find(id)
  @users = User.all()
  @habits = Habit.all()
  @messageboards = @habit.messageboards
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
  id = params.fetch('id').to_i
  @habit = Habit.find(id)
  @messageboards = @habit.messageboards
  redirect "/habits/#{habit.id}"

end

patch '/habits/:id/update' do
  id = params.fetch('id')
  @habit = Habit.find(id)
  name = params.fetch('habit_name', @habit.name)
  article = params.fetch('article', @habit.article)
  @habit.update({name: name, article: article})
  id = params.fetch('id').to_i
  @users = User.all()
  @habits = Habit.all()
  @messageboards = @habit.messageboards
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
  #session lines
  id = params.fetch('id')

  if @@current_user.id == id.to_i
    @user = User.find(id)
    @habits = Habit.all
    erb :user_detail
  else
    erb :user_error
  end
end

post '/users/:id/habits/new' do
  habit_id = params.fetch('habit_id').to_i
  user_id = params.fetch('id').to_i
  habit = Habit.find(habit_id)
  user = User.find(user_id)
  habit.users.push(user)
  @habits = Habit.all
  @users = User.all()

  redirect "/user/#{user.id}"

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
    @habits = Habit.all
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

# Messages

get '/habits/:id' do
  id = params.fetch('id').to_i
  @habit = Habit.find(id)
  @users = User.all()
  id = params.fetch('id').to_i
  @habits = Habit.all()
  @messageboards = @habit.messageboards
  erb :habit_detail

end
#
# get '/messages/new' do
#   id = params.fetch('id').to_i
#   @habit = Habit.find(id)
#   @users = User.all()
#   id = params.fetch('id').to_i
#   @habits = Habit.all()
#   @messageboards = @habit.messageboards
#   redirect"/habits/#{@habit.id}"
# end

post '/messages/new' do
  habit_id = params.fetch('habit_id').to_i
  habit = Habit.find(habit_id)
  title = params.fetch('title')
  message = params.fetch('message')
  @message = Messageboard.create({:message => message, :title => title, :habit_id => habit_id})
  @messageboards = Messageboard.all()
  @habit= habit.messageboards.push(@message)
  @habits=Habit.all()
  redirect"/habits/#{habit.id}"
end
