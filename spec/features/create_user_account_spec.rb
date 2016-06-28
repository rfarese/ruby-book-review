require 'rails_helper'

# As a prospective user
# I want to create an account
# So that I can post lakes and review them

# Acceptance Criteria:
# There is an option to create a new user account on the top of every page (in the nav bar) if I'm not already authenticated
# I must specify a valid and unique email address
# I must specify a unique username
# I must provide a unique password
# I can provide an optional user profile picture
# If I've entered valid information, I receive an onscreen message that my account has been created
# If I didn't enter valid information, I receive an error message and I am left unauthenticated
# If I'm already authenticated, I don't have the option to create a new user account

RSpec.feature "User creates a new account", type: :feature do
  scenario "User sees link to create a new account" do
    visit "/"

    expect(page).to have_content("Sign Up")
  end

  scenario "User successfully creates a new account"
    # check for messages
    # check for the lack of a "Sign Up"
  scenario "User doesn't provide a valid email address"
    # check for uniqueness
    # check for invalid email syntax
  scenario "User doesn't provide a valid password"
    # check to see if password matches password confirmation
    # check for uniqueness
  scenario "User doesn't provide a profile picture"
    # check to see if the user is still authenticated with the absence of a profile picture
end
