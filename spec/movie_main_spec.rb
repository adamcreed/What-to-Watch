require 'movie_main'

describe 'movie lookup' do
  before :all do
    @movies_by_id, @movies_by_title = create_movie_lists
    @users = create_user_list
    @movies_by_id, @users = get_ratings(@movies_by_id, @users)
    @rankings_list = create_movie_rankings(@movies_by_id)
  end

  describe '#create_movie_lists' do
    it 'creates movie list by id with movie id and title' do
      expect(@movies_by_id[1].title).to eq "Toy Story (1995)"
      expect(@movies_by_title.has_key?('Toy Story (1995)')).to eq true
    end
  end

  describe '#create_user_list' do
    it 'creates a list of movielens users' do
      expect(@users.size).to eq 943
    end
  end

  describe '#get_ratings' do
    it 'reads ratings from the reviews file and assigns them to movie and user files' do
      expect(@movies_by_id[1].ratings.empty?).to eq false
      expect(@users[10].ratings.empty?).to eq false
    end
  end

  describe '#movie_rankings' do
    it 'creates list (array) of all movies with their id and average rating' do
      expect(@rankings_list[0][1]).to eq 483
    end
  end

  describe '#top_ten_recommendations' do
    it "gives a list of the top ten movies that a user hasn't seen" do
      recommendations = top_ten_recommendations(@users[1], @rankings_list)

      expect(recommendations.size).to eq 10
    end
  end

  describe '#user_chose_lookup?' do
    it 'checks which option was chosen' do
      expect(user_chose_lookup?('1')).to eq true
    end
  end

  describe '#search_movies' do
    it 'looks for an entered string within the movie list' do
      movie_list = search_movies(@movies_by_title, 'star wars')

      expect(movie_list.keys).to eq ['Star Wars (1977)']
    end
  end

  describe '#is_int?' do
    context 'when a number is entered' do
      it 'checks if the text entered is an integer' do
        expect(is_int?('1')).to eq true
      end
    end

    context 'when a letter is entered' do
      it 'checks if the text entered is an integer' do
        expect(is_int?('s')).to eq false
      end
    end
  end

  describe '#is_within_bounds?' do
    context 'when a valid number is entered' do
      it 'checks if a number falls within a given range' do
        expect(is_within_bounds?(2, 1..2)).to eq true
      end
    end

    context 'when an invalid number is entered' do
      it 'checks if a number falls within a given range' do
        expect(is_within_bounds?(3, 1..2)).to eq false
      end
    end
  end
end
