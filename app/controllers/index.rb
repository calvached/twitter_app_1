get '/' do
  erb :index
end

post '/' do
  $client.update(params[:tweet]);
  redirect '/'
end

get '/:username' do
  @user = User.find_or_create_by_username(params[:username])
  @tweets = @user.tweets
  if @tweets.empty?
    @user.fetch_tweets!
    @tweets = @user.tweets
  elsif (Time.now - @user.updated_at) > @user.average_tweet_time || (Time.now - @user.updated_at) > 43200
    @user.tweets.map(&:destroy)
    @user.fetch_tweets!
    @tweets = @user.tweets
  end
  erb :user_tweets, layout: !request.xhr?
end


