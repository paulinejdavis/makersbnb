require 'sinatra/base'
require 'sinatra/reloader'
require'space_repository.rb'
require 'space.rb'
require 'user_repository.rb'
require 'user.rb'


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:signup)
  end

  post '/' do
    user_repo = UserRepository.new
    all_users = user_repo.all
    
    new_user = User.new

    new_user.name = params[:name]
    new_user.email = params[:email]
    new_user.password = params[:password]

    if all_users.any?{|user| user.email == new_user.email}
      return erb(:invalid_email)
    end

    user_repo.signup(new_user)

    return erb(:spaces)
  end
end