class Rank < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  validates :score, presence: true
  validates_inclusion_of :score, in: 1..5
  validates :book_id, presence: true
  validates :user_id, presence: true
end
