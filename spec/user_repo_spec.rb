require 'users'
require 'users_repository'

def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  context "when sign_up is called" do
    it "creates a user" do
      repo = UserRepository.new
      user = Users.new
      user.name = "John"
      user.email = "john1@gmail.com"
      user.password = "1234"

      repo.sign_up(user)
      users = repo.all

      expect(users.length).to eq(4)
      expect(users[3].name).to eq('John')
    end
  end

end
