module TwitterUserCreatorHelper
  def create_twitter_user
    User.create(
      provider: "twitter",
      uid: "uid1",
      first_name: "bobby",
      last_name: "jonesithanuel",
      # token: "1234",
      # secret: "abigsecret"
    )
  end
end
