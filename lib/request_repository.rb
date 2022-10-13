require 'request'

class RequestRepository
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

        sql = 'SELECT * FROM spaces WHERE user_id = $1;'
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


end