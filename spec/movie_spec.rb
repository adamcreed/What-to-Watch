require 'movie'

describe Movie do
  describe "#new" do
    it "it creates a movie with an id, title and rating" do
      #Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      #Act

      #Assert
      expect(movie.movie_id).to eq 1
      expect(movie.title).to eq 'Toy Story'
    end
  end

  describe "#ratings" do
    it "gives the list of individual ratings" do
      #Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      #Act
      movie.ratings = [3, 4, 5]
      #Assert
      expect(movie.ratings).to eq [3, 4, 5]
    end
  end

  describe "#get_average_rating" do
    it "gives the average rating for a movie" do
      #Arrange
      movie = Movie.new(movie_id: 1, title: 'Toy Story')
      #Act
      movie.ratings = [3, 4, 5]
      #Assert
      expect(movie.get_average_rating).to eq 4
    end
  end
end