require './config/environment'
require 'rack-flash'

class ConsoleController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/consoles' do
    if logged_in?
      erb :'consoles/index'
    else
      redirect '/login'
    end
  end

  get '/consoles/new' do
    if logged_in?
      erb :'consoles/new'
    else
      redirect '/login'
    end
  end

  post '/consoles' do
    @console = Console.new(name: params[:name], user_id: session[:id])
    if @console.valid?
      @console.save
      redirect "/consoles"
    else
      flash[:message] = "Error! Console must have a name!"
      redirect '/consoles/new'
    end
  end

  get '/consoles/:id' do
  if logged_in?
    @console = Console.find_by(id: params[:id], user_id: session[:id])
    erb :'consoles/show'
  else
    redirect '/login'
  end
end

  get '/consoles/:id/edit' do
    if logged_in?
      @console = Console.find_by(id: params[:id], user_id: session[:id])
      erb :'consoles/edit'
    else
      redirect '/login'
    end
  end

  patch '/consoles/:id' do
    @console = Console.find_by(id: params[:id], user_id: session[:id])
    @console.name = params[:name]
    @console.save
    redirect to "/consoles/#{@console.id}"
  end

  delete '/consoles/:id/delete' do
    if logged_in?
      @console = Console.find_by(id: params[:id], user_id: session[:id])
      @tweet.delete
      redirect to '/consoles'
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end
end
