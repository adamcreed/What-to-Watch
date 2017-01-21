require 'csv'
require_relative 'movie'

def main; end

def create_movie_list
  movies = {}
  CSV.foreach('ml-100k/u.item.csv',
              col_sep: '|', encoding: 'iso-8859-1') do |row|
    movie = Movie.new(movie_id: row[0].to_i, title: row[1])
    movies[movie.movie_id] = movie
  end
  movies
end

main if __FILE__ == $PROGRAM_NAME
