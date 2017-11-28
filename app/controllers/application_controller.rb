require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end


  get '/' do
    if logged_in?
      redirect "/users/#{@current_user.id}"
    else
    erb :'users/index'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{@current_user.id}"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.valid?
      @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Error! Neither Username nor Password cannot be empty!"
      redirect '/signup'
    end
  end

  get '/login' do
    if  logged_in?
      redirect "/users/#{@current_user.id}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Error! Username or Password does not match!"
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Logout Successful"
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:id' do
    if logged_in?
      if @current_user.id == User.find(params[:id]).id
        @user =  User.find(params[:id])
        erb :'users/show'
      else
        flash[:message] = "Cannot view another users page!"
        redirect "/users/#{session[:id]}"
      end
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
