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

    describe '#create_space' do
      repo = SpaceRepository.new
      space = Space.new
      space.name = 'Treehouse'
      space.description = 'Lovely place in the forest'
      space.price_per_night = 120
      space.available_dates = '12/03/2023, 12/04/2023'
      space.user_id = 1

      repo.create_space(space)
  
      all_spaces = repo.all

      expect(all_spaces.length).to eq 3
      expect(all_spaces.last.name).to eq 'Treehouse'
      expect(all_spaces.last.description).to eq'Lovely place in the forest'
      expect(all_spaces.last.price_per_night).to eq 120
      expect(all_spaces.last.available_dates).to eq '12/03/2023, 12/04/2023'
    end
end


