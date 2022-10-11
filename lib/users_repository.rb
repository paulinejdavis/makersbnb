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
    sql = 'UPDATE users SET loggedin = true WHERE email = $1;'
    result_set = DatabaseConnection.exec_params(sql, [email])
  end

  def log_out(email)
    sql = 'UPDATE users SET loggedin = false WHERE email = $1;'
    result_set = DatabaseConnection.exec_params(sql, [email])
  end

  def loggedin(email)
      sql = 'SELECT loggedin FROM users WHERE email = $1;'
      result_set = DatabaseConnection.exec_params(sql, [email])
      answer = result_set[0]['loggedin']
      return answer
  end
end