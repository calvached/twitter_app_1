class User < ActiveRecord::Base
  has_many :tweets
  validates :username, presence: true, uniqueness: true

  def fetch_tweets!
    self.updated_at = Time.now
    $client.user_timeline(self.username, :result_type => :recent).take(10).each do |tweet|
      Tweet.create(user_id: self.id, content: tweet.text, created_at: tweet.created_at)
    end
  end

  def average_tweet_time
    tweet_times = self.tweets.map(&:created_at)
    length = tweets.length
    difference_of_tweet_time = tweet_times.map.with_index do |created_at, index|
      if index < (length - 1)
       created_at - tweet_times[index+ 1]
      else
        Time.now - created_at
      end
    end
    difference_of_tweet_time.reduce(:+) / difference_of_tweet_time.length
  end
end
