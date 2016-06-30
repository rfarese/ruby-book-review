class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :title, presence: true
  validates :description, presence: true 
end
