require 'movie_main'

describe 'create_movie_list' do
  it 'create movie list with movie id and title' do
    #Arrange
    movies = {}
    #Act
    movies = create_movie_list
    #Assert
    expect(movies[1].title).to eq "Toy Story (1995)"
  end
end
