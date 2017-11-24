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





    helpers do
      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= User.find(session[:id]) if session[:id]
      end
    end
  end
