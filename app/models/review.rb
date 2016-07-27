class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true

  def up_votes
    total_votes = 0
    votes.each { |vote| total_votes += 1 if vote.up_vote == true }
    total_votes
  end

  def down_votes
    total_votes = 0
    votes.each { |vote| total_votes += 1 if vote.down_vote == true }
    total_votes
  end

  def score
    up_votes - down_votes
  end

  def has_votes?
    votes != [] && votes != nil
  end

  def has_user_voted?(user)
    Vote.where(user_id: user.id, review_id: self.id)
  end

  def build_tweet
    book = Book.where(id: self.book_id).first
    "Checkout my book review on #{book.title}!"
  end

  def send_tweet
    client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["TWITTER_API_KEY"]
        config.consumer_secret = ENV["TWITTER_API_SECRET"]
        config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end
    client.update(build_tweet)
  end
end
