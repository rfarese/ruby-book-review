module AuthenticationHelper
  def sign_in_twitter_user(user)
    mock_auth_for(user)
    visit "/"
    click_link "Sign In"
    click_link "Sign in with Twitter"
  end

  def mock_auth_for(user)
    mock_options = {
      uid: user.uid,
      provider: user.provider,
      info: {
        name: user.first_name,
        nickname: user.last_name
      }
    }
    OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
  end
end
