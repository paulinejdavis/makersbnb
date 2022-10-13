require 'request'
require 'space'

class RequestRepository

    def all
        requests = []

        sql = 'SELECT * FROM requests;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
            request = Request.new
            request.id = record['id'].to_i
            request.approved = record['approved']
            request.requested_date = record['requested_date']
            request.user_id = record['user_id'].to_i
            request.space_id = record['space_id'].to_i
            
            requests << request
        end
        return requests
    end

    def find(id)
        sql = 'SELECT * FROM requests WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])

        request = Request.new
        request.id = result_set[0]['id'].to_i
        request.approved = result_set[0]['approved']
        request.requested_date = result_set[0]['requested_date']
        request.user_id = result_set[0]['user_id'].to_i
        request.space_id = result_set[0]['space_id'].to_i

        return request
    end

    def all_by_user(id_from_user)
        requests = []

        sql = 'SELECT * FROM requests WHERE user_id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id_from_user])
        result_set.each do |record|
            request = Request.new
            request.id = record['id'].to_i
            request.approved = record['approved']
            request.requested_date = record['requested_date']
            request.user_id = record['user_id'].to_i
            request.space_id = record['space_id'].to_i
            
            requests << request
        end
        return requests
    end

    def all_for_user(id_from_posting_user)
        requests = []
        
        spaces = []

        sql = 'SELECT * FROM spaces WHERE user_id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id_from_posting_user])
        result_set.each do |record|
            space = Space.new
            space.id = record['id'].to_i
            space.user_id = record['user_id'].to_i

            spaces << space
        end
        
        spaces.each do |space|
          sql = 'SELECT * FROM requests WHERE space_id = $1;'
          result_set = DatabaseConnection.exec_params(sql, [space.id])
          result_set.each do |record|
            request = Request.new
            request.id = record['id'].to_i
            request.approved = record['approved']
            request.requested_date = record['requested_date']
            request.user_id = record['user_id'].to_i
            request.space_id = record['space_id'].to_i
        
            requests << request
          end
        end
        return requests
    end

    def create_request(new_request)
      sql = 'INSERT INTO requests (approved, requested_date, user_id, space_id) VALUES ($1, $2, $3, $4);'
      DatabaseConnection.exec_params(sql, [new_request.approved, new_request.requested_date, new_request.user_id, new_request.space_id])
    end

    def approve_request(id)
        sql = 'UPDATE requests SET approved = true WHERE id = $1;'
        DatabaseConnection.exec_params(sql, [id])
    end

end