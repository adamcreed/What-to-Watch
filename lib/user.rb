class User
attr_reader :user_id
attr_accessor :user_ratings

  def initialize(options)
    @user_id = options[:user_id]
    @user_ratings = {}
  end
end
