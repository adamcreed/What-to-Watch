# File creating Movie class
class Movie
  attr_reader :movie_id, :title
  attr_accessor :ratings

  def initialize(options)
    @movie_id = options[:movie_id]
    @title = options[:title]
    @ratings = {}
  end

  def average_rating
    # @ratings.inject(:+) / @ratings.size
    sum = 0
    @ratings.each_value { |rating| sum += rating.to_f }
    (sum / @ratings.size).round(2)
  end
end
