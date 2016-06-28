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
    visit root_path

    expect(page).to have_content("Sign Up")
  end

  scenario "user provides valid and required information" do
    # check for messages
    # check for the lack of a "Sign Up"
    visit root_path
    click_link "Sign Up"
    fill_in "user_first_name", with: "Jon"
    fill_in "user_last_name", with: "Smith"
    fill_in "Email", with: 'user@example.com'
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
    expect(page).to_not have_content("Sign Up")
  end

  scenario "User doesn't provide any email address" do
    visit root_path
    click_link "Sign Up"
    fill_in "user_first_name", with: "Jon"
    fill_in "user_last_name", with: "Smith"
    fill_in "Email", with: ''
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
  end

  scenario "User doesn't provide a valid email address" do
    visit root_path
    click_link "Sign Up"
    fill_in "user_first_name", with: "Jon"
    fill_in "user_last_name", with: "Smith"
    fill_in "Email", with: 'user'
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Email is invalid")
  end

  scenario "User password doesn't match with their password confirmation" do 
  visit root_path
  click_link "Sign Up"
  fill_in "user_first_name", with: "Jon"
  fill_in "user_last_name", with: "Smith"
  fill_in "Email", with: 'user@example.com'
  fill_in "user_password", with: "password"
  fill_in "Password confirmation", with: "differentPassword"
  click_button "Sign up"

  expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
