require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

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
      expect(response.body).to include("<h1>Sign-in to Makersbnb</h1>")
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
end
