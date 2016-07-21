require 'rails_helper'

RSpec.feature "User signs in with Twitter;", type: :feature do

# NOTE  - need to configure testing environment for omniauth authentication to get this test passing
#       - check rescue mission problem on how to do this
#       - intial sign in and sign out is working with Twitter authentication
#       - still need to work on sending automatic tweet through twitter gem

  # Acceptance Criteria:
  # * User views "Log in with Twitter" in the navigation bar
  # * User successfully logs into the site with their Twitter account
  # * A user authenticated through Twitter doesn't view the ability to log in

  scenario "User views the ability to log in with their Twitter account" do
    visit root_path
    click_link "Sign In"

    expect(page).to have_content("Sign in with Twitter")
  end

  scenario "User successfully logs into the site with ther Twitter credentials" do
    visit root_path
    click_link "Sign In"
    # click_link "Sign in with Twitter"

  end

  scenario "A Twitter authenticated user no longer views the ability to log in"
end
