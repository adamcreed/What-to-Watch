require 'csv'  #for cvs methods
require_relative 'movie'
require_relative 'user'

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

def create_movie_rankings(movies_by_id)
  movie_rankings =[]
  movies_by_id.each_value do |movie|
    movie_rankings << [movie.average_rating, movie.movie_id] unless has_few_reviews?(movie)
  end
  movie_rankings.sort.reverse
end

def top_ten_recommendations(user, movie_rankings)
  recommendations = []
  # movie_ids = movie_rankings[1].skip(user_has_seen).take(10)

  movie_rankings.each do |movie|
    add_recommendation(user, movie, recommendations)
    break if list_is_full?(recommendations)
  end
  recommendations
end

def list_is_full?(recommendations)
  recommendations.count == 10
end

def has_few_reviews?(movie)
  movie.ratings.size < 100
end

def add_recommendation(user, movie, recommendations)
  recommendations << movie[1] unless user_has_seen?(user, movie[1])
end

def user_has_seen?(user, movie_id)
  user.ratings.has_key?(movie_id)
end

def get_recommendations(users, movie_rankings, movies_by_id)
  print "\nPlease give my your user ID: "
  user_id = gets.chomp

  until is_int?(user_id) and is_within_bounds?(user_id, 1..943)
    print "Please enter a valid user ID (1-943): "
    user_id = gets.chomp
  end

  puts
  recommendation_list_ids = top_ten_recommendations(users[user_id.to_i], movie_rankings)

  puts "Here are the top ten recommendations just for you:\n\n"
  recommendation_list_ids.each {|id| puts movies_by_id[id].title}
  puts "\n"
end

def lookup_movie(movies_by_title)
  print "What movie would you like to look up? "
  movie_to_look_up = gets.chomp.downcase
  movie_list = movies_by_title.select {|title, movie| title.downcase.include? movie_to_look_up}
  movie_list.each { |title, movie| puts movie }
end

def user_chose_lookup?(action)
  action == '1'
end

def is_int?(input)
  input.to_i.to_s == input
end

def is_within_bounds?(input_number, range)
  range.include? input_number.to_i
end

def main
  movies_by_id, movies_by_title = create_movie_lists
  users = create_user_list
  movies_by_id, users = get_ratings(movies_by_id, users)
  movie_rankings = create_movie_rankings(movies_by_id)

  print "Would you like to look up a movie (1) or get recommendations (2) ? "
  action = gets.chomp
  until is_int?(action) and is_within_bounds?(action, 1..2)
    print 'Please enter 1 or 2: '
    action = gets.chomp
  end

  if user_chose_lookup?(action)
    lookup_movie(movies_by_title)
  else
    get_recommendations(users, movie_rankings, movies_by_id)
  end
end

main if __FILE__ == $PROGRAM_NAME
