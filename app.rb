require 'sinatra'
require 'sinatra/activerecord'

configure(:development){set :database, "sqlite:///blog.sqlite3"}
set :sessions, true
 
get '/' do 
	@user = current_user
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
  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
      flash[:notice] = "You've been signed in successfully :)"
      session[:user_id] = @user.id
      redirect '/userhome'
  else
    flash[:notice] = "There was a problem signing you in :("
  end
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  User.create(params[:user])
  redirect '/userhome'
end

get '/userhome' do 
	erb :userhome
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
