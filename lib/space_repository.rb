require_relative './database_connection.rb'
require_relative 'space'

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
        space.image_link = record['image_link']
        space.user_id = record['user_id'].to_i

        spaces << space
    end
    return spaces
  end

  def create_space(space)
    sql = 'INSERT INTO spaces (name, description, price_per_night, available_dates, image_link, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
    result_set = DatabaseConnection.exec_params(sql, [space.name, space.description, space.price_per_night, space.available_dates, space.image_link, space.user_id])

    return space
  end

  def find(id)
    sql = 'SELECT id, name, description, price_per_night, available_dates, image_link, user_id FROM spaces WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    space = Space.new
    space.id = result_set[0]['id'].to_i
    space.name = result_set[0]['name']
    space.description = result_set[0]['description']
    space.price_per_night = result_set[0]['price_per_night'].to_i
    space.available_dates = result_set[0]['available_dates']
    space.image_link = result_set[0]['image_link']
    space.user_id = result_set[0]['user_id'].to_i

    return space
  end
end