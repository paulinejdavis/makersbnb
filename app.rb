require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repository.rb'
require_relative 'lib/space.rb'
require_relative 'lib/user_repository.rb'
require_relative 'lib/user.rb'
require_relative 'lib/database_connection'

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

  post '/' do
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

    return erb(:spaces)
  end

  get '/post_space' do
    return erb(:post_space)
  end

  post '/post_space' do
    space_repo = SpaceRepository.new
    user_repo = UserRepository.new
    new_space = Space.new

    new_space.name = params[:name]
    new_space.description = params[:description]
    new_space.price_per_night = params[:price_per_night].to_i
    new_space.available_dates = params[:available_dates]
    new_space.user_id = user_repo.find_by_email(params[:email]).to_i

    space_repo.create_space(new_space)
    return erb(:space_created)
  end

  get '/:id' do
    space_repo = SpaceRepository.new
    @space = space_repo.find(params[:id])

    return erb(:individual_space)
  end
end