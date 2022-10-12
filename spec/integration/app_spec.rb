require "spec_helper"
require "rack/test"
require_relative '../../app.rb'
require 'json'

require 'space_repository.rb'
require 'space.rb'
require 'user_repository.rb'
require 'user.rb'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Book a Space</h1>")
      expect(response.body).to include("<a href='/post_space'>Add a new space</a>")
    end
  end
  context 'GET /signup' do
    it 'should display the signup form' do
      response = get('/signup')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Sign Up to Makersbnb</h1>")
      expect(response.body).to include("<label>Email:</label>")
    end
  end

  context 'POST /' do
    it 'should show the spaces page' do
      response = post(
       '/',
       name: 'John',
       email: 'john1@gmail.com',
       password: '12345678a'
      )

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Book a Space</h1>")
    end
  end

  context 'GET /post_space' do
    it 'should show the post a space page' do
      response = get('/post_space')

      expect(response.status).to eq (200)
      expect(response.body).to include ("<h1>Post a space</h1>")
      expect(response.body).to include ('<input type="submit" value="Add your space to Makersbnb">')
    end
  end
 
  context 'POST /space_created' do
    it 'Should return a success page' do
      response = post(
        '/space_created',
        email: 'jonh1@gmail.com',
        name: 'Treehouse',
        description: 'A house',
        available_dates: '22/03/2022, 23/03/2022'
       )
      expect(response.status).to eq (200)
      expect(response.body).to include ("</h1>Your space has been successfully created</h1>")
      expect(response.body).to include ("<a href='/'>Go back to main page</a>")
    end
  end
end
