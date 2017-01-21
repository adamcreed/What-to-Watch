require 'user'

describe User do
  describe '#new' do
    it 'creates a new movielens user' do
      #Arrange
      user = User.new(2, 24)
      #Assert
      expect(user.user_id).to eq 2
    end
  end
end
