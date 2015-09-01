require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  erb :index
end

get '/form_habits' do

  erb :habit_form
end

get '/break_habits' do

  erb :habit_break
end

get '/habit_form' do

  erb :habit_form
end

post '/post_form' do

end
