require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space_repository.rb'
require './lib/space.rb'
require './lib/user_repository.rb'
require './lib/user.rb'
require './lib/database_connection'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    space_repo = SpaceRepository.new
    @spaces = space_repo.all
    return erb(:spaces)
  end

  
  get '/signup' do
    return erb(:signup)
  end 

  get'/spacesloggedin' do
    space_repo = SpaceRepository.new
    @spaces = space_repo.all
    return erb(:signed_loggedin)
  end

  post '/spacesloggedin' do
    user_repo = UserRepository.new
    # all_users = user_repo.all
    space_repo = SpaceRepository.new
    @spaces = space_repo.all
    
    new_user = User.new

    new_user.name = params[:name]
    new_user.email = params[:email]
    new_user.password = params[:password]

    # if all_users.any?{|user| user.email == new_user.email}
    #   return erb(:invalid_email)
    # end

    user_repo.sign_up(new_user)

    return erb(:signed_loggedin)
  end

  
end