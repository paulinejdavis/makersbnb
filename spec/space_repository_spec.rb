require 'space.rb'
require 'space_repository'
require 'database_connection'

def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
    connection.exec(seed_sql)
end


describe SpaceRepository do 
    before(:each) do
        reset_table
    end

    describe '#all' do
        it 'returns all spaces' do
            repo = SpaceRepository.new
            all_spaces = repo.all

            expect(all_spaces.length).to eq(2)
            expect(all_spaces.first.id).to eq(1)
            expect(all_spaces.first.name).to eq('The Coza, Joshua Tree')
            expect(all_spaces.first.price_per_night).to eq(145)
        end
    end
end


