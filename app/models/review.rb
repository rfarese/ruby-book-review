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
end
