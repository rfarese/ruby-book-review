class Book < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :ranks, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :description, presence: true, uniqueness: true

  mount_uploader :cover_photo, CoverPhotoUploader

  def num_of_rankings
    ranks.size.round(1)
  end

  def rankings_sum
    sum = 0.0
    ranks.each do |rank|
      sum += rank.score.round(1)
    end
    sum
  end

  def average_rank
    (rankings_sum / num_of_rankings).round(1)
  end

  def best_review
    best_review = reviews.first

    reviews.each do |review|
      best_review = review if review.score > best_review.score
    end
    best_review
  end

  def has_reviews?
    reviews != [] && reviews != nil
  end
end
