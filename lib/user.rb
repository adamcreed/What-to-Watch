class User
  attr_reader :user_id, :age
  attr_accessor :ratings

  def initialize(user_id, age)
    @user_id = user_id
    @age = age
    @ratings = {}
  end
end
