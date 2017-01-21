require 'movie_main'

describe 'create_movie_lists' do
  it 'creates movie list by id with movie id and title' do
    #Arrange
    #Act
    movies_by_id, movies_by_title = create_movie_lists
    #Assert
    expect(movies_by_id[1].title).to eq "Toy Story (1995)"
    expect(movies_by_title.has_key?('Toy Story (1995)')).to eq true

  end
end

describe 'create_user_list' do
  it 'creates a list of movielens users' do
    #Arrange
    #Act
    users = create_user_list
    #Assert
    expect(users.size).to eq 943
  end
end

describe 'get_ratings' do
  it 'reads ratings from the reviews file and assigns them to movie and user files' do
    movies_by_id, movies_by_title = create_movie_lists
    users = create_user_list

    movies_by_id, users = get_ratings(movies_by_id, users)

    expect(movies_by_id[1].ratings.empty?).to eq false
    expect(users[10].ratings.empty?).to eq false
  end
end

describe 'movie_rankings' do
  it 'creates list (array) of all movies with their id and average rating' do
    movies_by_id, movies_by_title = create_movie_lists
    users = create_user_list

    movies_by_id, users = get_ratings(movies_by_id, users)
    rankings_list = create_movie_rankings(movies_by_id)

    expect(rankings_list[0][1]).to eq 408
  end
end

describe 'top_ten_recommendations' do
  it "gives a list of the top ten movies that a user hasn't seen" do
    #Arrange
    movies_by_id, movies_by_title = create_movie_lists
    users = create_user_list
    movies_by_id, users = get_ratings(movies_by_id, users)
    rankings_list = create_movie_rankings(movies_by_id)
    #Act
    recommendations = top_ten_recommendations(users[1], rankings_list)
    #Assert
    expect(recommendations.size).to eq 10
  end
end
