require 'user'
require 'user_repository'

def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  it "shows all users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq(3)
    expect(users[0].name).to eq('Ruby')
  end

  context "when sign_up is called" do
    it "creates a user" do
      repo = UserRepository.new
      user = User.new
      user.name = "John"
      user.email = "john1@gmail.com"
      user.password = "1234"

      repo.sign_up(user)
      users = repo.all

      expect(users.length).to eq(4)
      expect(users[3].name).to eq('John')
    end
  end

  context "when user logs in" do
    it "marks user as logged in" do
      repo = UserRepository.new
      repo.log_in('joe@gmail.com')
      expect(repo.loggedin('joe@gmail.com')).to eq 'true'
      expect(repo.loggedin('joe@gmail.com')).not_to be 'false'
    end
  end

  context "when user logs out" do
    it "marks user as logged out" do
      repo = UserRepository.new
      repo.log_out('ruby1@gmail.com')
      expect(repo.loggedin('ruby1@gmail.com')).to eq 'false'
      expect(repo.loggedin('ruby1@gmail.com')).not_to be 'true'
    end
  end

  context "find_by_email(email)" do
    it "finds a user by their email" do
      repo = UserRepository.new

      expect(repo.find_by_email("joe@gmail.com")).to eq 2
    end
  end
  
end
