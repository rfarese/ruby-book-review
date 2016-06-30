class Book < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :description, presence: true, uniqueness: true 
end
