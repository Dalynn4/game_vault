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
    erb :'users/index'
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

    helpers do
      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= User.find(session[:id]) if session[:id]
      end
    end
  end
