require './config/environment'
require 'rack-flash'

class GameController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/games' do
    if logged_in?
      erb :'games/index'
    else
      redirect '/login'
    end
  end

  get '/games/new' do
    if logged_in?
      erb :'games/new'
    else
      redirect '/login'
    end
  end

  post '/games' do
    @game = Game.new(name: params[:name], user_id: session[:id], console_id: params[:console_id])
    if @game.valid?
      @game.save
      redirect "/games"
    else
      flash[:message] = "Error! Game must have a name!"
      redirect '/games/new'
    end
  end

  get '/games/:id' do
  if logged_in?
    @game = Game.find_by(id: params[:id], user_id: @current_user.id)
    erb :'games/show'
  else
    redirect '/login'
  end
end

  get '/games/:id/edit' do
    if logged_in?
      @game = games.find_by(id: params[:id], user_id: @current_user.id)
      erb :'games/edit'
    else
      redirect '/login'
    end
  end

  patch '/games/:id' do
    @game = Game.find_by(id: params[:id], user_id: session[:id])
    @game.name = params[:name]
    @game.save
    redirect to "/games/#{@game.id}"
  end

  delete '/games/:id/delete' do
    if logged_in?
      @game = Game.find_by(id: params[:id], user_id: @current_user.id)
      @game.delete
      redirect to '/games'
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
