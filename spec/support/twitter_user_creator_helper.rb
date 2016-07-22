module TwitterUserCreatorHelper
  def create_twitter_user
    User.create(
      provider: "twitter",
      uid: "uid1",
      first_name: "bobby",
      last_name: "jonesithanuel",
      email: "defaultemail@yahoo.com",
      password: Devise.friendly_token[0,20]
    )
  end
end
