require 'movie'

describe Movie do
  before :all do
    @movie = Movie.new(movie_id: 1, title: 'Toy Story')
    @movie.ratings = {1 => 3, 2 => 4, 3 => 5}
  end

  describe '#new' do
    it 'it creates a movie with an id, title and rating' do
      expect(@movie.movie_id).to eq 1
      expect(@movie.title).to eq 'Toy Story'
    end
  end

  describe '#ratings' do
    it 'gives the list of individual ratings' do
      expect(@movie.ratings).to eq({1 => 3, 2 => 4, 3 => 5})
    end
  end

  describe '#average_rating' do
    it 'gives the average rating for a movie' do
      expect(@movie.average_rating).to eq 4
    end
  end

  describe '#to_s' do
    it 'gives the title and average rating of a movie' do
      expect(@movie.to_s).to eq "Title: Toy Story\nRating: 4.0"
    end
  end
end
