require 'request_repository'
require 'request'

def reset_request_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'makersbnb_test'})
    connection.exec(seed_sql)
end

describe RequestRepository do
    before(:each) do
        reset_request_table
    end

    describe '#all_by_user' do
        it 'finds all requests made by user' do
            repo = RequestRepository.new

            result = repo.all_by_user(1)

            expect(result.length).to eq(1)
            expect(result.first.id).to eq(1)
            expect(result.first.requested_date).to eq('16/10/2022')
            expect(result.first.space_id).to eq(2)  
         end
    end




end
