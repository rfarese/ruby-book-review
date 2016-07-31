class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter]
  has_many :books
  has_many :reviews
  has_many :votes
  has_many :ranks
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = auth.info.name
      user.last_name = auth.info.nickname
      user.email = "defaultemail@yahoo.com"
      user.password = Devise.friendly_token[0,20]
    end
  end
end
