require 'movie'

describe Movie do
  describe '#new' do
    it 'it creates a movie with an id, title and rating' do
      # Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      # Act
      # Assert
      expect(movie.movie_id).to eq 1
      expect(movie.title).to eq 'Toy Story'
    end
  end

  describe '#ratings' do
    it 'gives the list of individual ratings' do
      # Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      #Act
      movie.ratings = {1 => 3, 2 => 4, 3 => 5}
      #Assert
      expect(movie.ratings).to eq({1 => 3, 2 => 4, 3 => 5})
    end
  end

  describe "#average_rating" do
    it "gives the average rating for a movie" do
      #Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      #Act
      movie.ratings = {1 => 3, 2 => 4, 3 => 5}
      #Assert
      expect(movie.average_rating).to eq 4
    end
  end
end
