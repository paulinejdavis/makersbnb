require_relative './database_connection.rb'
require_relative './space.rb'

class SpaceRepository
  def all
    spaces = []

    sql = 'SELECT * FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
        space = Space.new
        space.id = record['id'].to_i
        space.name = record['name']
        space.description = record['description']
        space.price_per_night = record['price_per_night'].to_i
        space.available_dates = record['available_dates']
        space.user_id = record['user_id'].to_i

        spaces << space
    end
    return spaces
  end
end