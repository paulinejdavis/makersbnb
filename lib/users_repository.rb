class UserRepository

  def all
    users = []
    sql = 'SELECT id, name, email, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|

      user = Users.new
      user.id = record['id'].to_i
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']
      users << user
    end

    return users
  end

  def sign_up(user)
    sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3);'
    result_set = DatabaseConnection.exec_params(sql, [user.name, user.email, user.password])
    return user
  end 

  def log_in(email)
    
  end

  def log_out(email)
  end

  def loggedin?
    # returns true or false
  end
end