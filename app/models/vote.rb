class Vote < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :up_vote, inclusion: { in: [true, false] }
  validates :down_vote, inclusion: { in: [true, false] }
  validates_uniqueness_of :user_id, scope: :review_id
end
