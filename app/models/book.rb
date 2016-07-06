class Book < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :ranks
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :description, presence: true, uniqueness: true

  def rankings
    Rank.where(book_id: self.id)
  end

  def num_of_rankings
    rankings.size.round(1)
  end

  def rankings_sum
    sum = 0.0
    rankings.each do |ranking|
      sum += ranking.rank.round(1)
    end
    sum
  end

  def average_rank
    (rankings_sum / num_of_rankings).round(1)
  end
end
