require 'sinatra'    
require 'sinatra/activerecord'
require './models'

configure(:development){set :database, "sqlite:///blog.sqlite3"}
set :sessions, true

require 'bundler/setup' 
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true 

get '/' do 
	@user = current_user
	@post = Post.all 
	erb :home
end

def current_user
  if session[:user_id]
    User.find(session[:user_id])
  else
    nil
  end
end

post '/sessions/new' do
  @user = User.where(email: params[:user][:email]).first
  if @user && @user.password == params[:user][:password]
      flash[:notice] = "You've been signed in successfully :)"
      session[:user_id] = @user.id
      redirect '/userhome'
  else
    flash[:notice] = "There was a problem signing you in :("
    	redirect '/'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  User.create(params[:user])
  redirect '/userhome'
end

get '/userhome' do
	@user = current_user
	erb :userhome
end

post '/userhome' do 
	Post.create(title: params[:title], text: params[:text], user_id: current_user.id)
	flash[:notice] = "Your post has been saved successfully :)"
	redirect '/userhome'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
  flash[:notice] = "You have been logged out successfully :)"
end
