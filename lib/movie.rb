class Movie
attr_reader :movie_id, :title
attr_accessor :ratings

  def initialize(options)
    @movie_id = options[:movie_id]
    @title = options[:title]
    @ratings = []
  end

  def get_average_rating
    # @ratings.inject(:+) / @ratings.size
    sum = 0
    @ratings.each {|num|sum += num}
    sum / ratings.size
  end
end
