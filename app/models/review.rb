class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true

  def number_of_votes
    votes.size
  end
end
