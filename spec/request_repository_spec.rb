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

    describe '#all' do
        it 'finds all requests' do
            repo = RequestRepository.new

            result = repo.all

            expect(result.length).to eq(3)
            expect(result.first.id).to eq(1)
            expect(result.first.requested_date).to eq('16/10/2022')
            expect(result.first.space_id).to eq(2)  
         end
    end

    describe "#find" do
      it "finds a request by id" do
        repo = RequestRepository.new

        result = repo.find(2)

        expect(result.requested_date).to eq('11/10/2022')
        expect(result.user_id).to eq(3)
      end
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

    describe "#all_for_user" do
       it "finds all requests that a user has received" do
         repo = RequestRepository.new

         result = repo.all_for_user(1)
         
         expect(result.length).to eq(2)
         expect(result.first.id).to eq(2)
         expect(result.first.requested_date).to eq('11/10/2022')
         expect(result.first.space_id).to eq(1)  
       end

       it "finds all requests that a user has received" do
        repo = RequestRepository.new

        result = repo.all_for_user(2)
        
        expect(result.length).to eq(1)
        expect(result.first.id).to eq(1)
        expect(result.first.requested_date).to eq('16/10/2022')
        expect(result.first.space_id).to eq(2)  
      end
    end

    describe '#create_request' do
        it 'adds a new request' do
            repo = RequestRepository.new

            new_request = Request.new
            new_request.approved = 'true'
            new_request.requested_date = '18/10/2022'
            new_request.user_id = 1
            new_request.space_id = 2

            repo.create_request(new_request)

            result = repo.all

            expect(result.length).to eq 4
            expect(result.last.id).to eq 4
            expect(result.last.approved).to eq 'true'
            expect(result.last.requested_date).to eq '18/10/2022'
            expect(result.last.user_id).to eq 1
            expect(result.last.space_id).to eq 2
        end
    end

    describe '#approve_request' do
        it 'changes request to approved' do
            repo = RequestRepository.new

            repo.approve_request(3)

            result = repo.find(3)
            expect(result.approved).to eq 'true'
            expect(result.requested_date).to eq '13/10/2022'
        end

    end
end
