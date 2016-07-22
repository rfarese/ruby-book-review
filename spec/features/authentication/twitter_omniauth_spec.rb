require 'rails_helper'

RSpec.feature "User authenticates with Twitter credentials;", type: :feature do

  scenario "User views the ability to log in with their Twitter account" do
    visit root_path
    click_link "Sign In"

    expect(page).to have_content("Sign in with Twitter")
  end

  scenario "User successfully logs into the site with ther Twitter credentials" do
    twitter_user = create_twitter_user
    sign_in_twitter_user(twitter_user)

    expect(page).to_not have_content("Sign in with Twitter")
    expect(page).to have_content("Sign Out")
  end

  scenario "Authenticated Twitter user signs out of the site" do
    twitter_user = create_twitter_user
    sign_in_twitter_user(twitter_user)
    click_link "Sign Out"

    expect(page).to_not have_content("Sign Out")
    expect(page).to have_content("Sign In")
  end
end
