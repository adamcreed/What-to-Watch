require 'csv'
require_relative 'movie'

def create_movie_lists
  movies_by_id = {}
  movies_by_title = {}

  CSV.foreach('ml-100k/u.item', col_sep: '|', encoding: 'iso-8859-1') do |row|
    movie = Movie.new(movie_id: row[0].to_i, title: row[1])
    movies_by_id[movie.movie_id] = movie
    movies_by_title[movie.title] = movie
  end
  [movies_by_id, movies_by_title]
end

def create_user_list
  users = {}

  CSV.foreach('ml-100k/u.user', col_sep: '|', encoding: 'iso-8859-1') do |row|
    user = User.new(row[0].to_i, row[1].to_i)
    users[user.user_id] = user
  end
  users
end

def get_ratings(movies_by_id, users)
  CSV.foreach('ml-100k/u.data', col_sep: ' ', encoding: 'iso-8859-1') do |row|
    user_id = row[0].to_i
    movie_id = row[1].to_i
    rating = row[2].to_i

    users[user_id].ratings[movie_id] = rating
    movies_by_id[movie_id].ratings[user_id] = rating
  end
  [movies_by_id, users]
end

def main

end



main if __FILE__ == $PROGRAM_NAME
