require 'rails_helper'

RSpec.feature "User creates a new account", type: :feature do

  def fill_in_up_to_last_name
    visit root_path
    click_link "Sign Up"
    fill_in "user_first_name", with: "Jon"
    fill_in "user_last_name", with: "Smith"
  end

  def fill_in_valid_passwords
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
  end

  scenario "User sees link to create a new account" do
    visit root_path

    expect(page).to have_content("Sign Up")
  end

  scenario "user provides valid and required information" do
    fill_in_up_to_last_name
    fill_in "Email", with: 'user@example.com'
    fill_in_valid_passwords
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
    expect(page).to_not have_content("Sign Up")
  end

  scenario "User doesn't provide any email address" do
    fill_in_up_to_last_name
    fill_in "Email", with: ''
    fill_in_valid_passwords
    click_button "Sign up"

    expect(page).to have_content("Email can't be blank")
  end

  scenario "User doesn't provide a valid email address" do
    fill_in_up_to_last_name
    fill_in "Email", with: 'user'
    fill_in_valid_passwords
    click_button "Sign up"

    expect(page).to have_content("Email is invalid")
  end

  scenario "User password doesn't match with their password confirmation" do
    fill_in_up_to_last_name
    fill_in "Email", with: 'user@example.com'
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "differentPassword"
    click_button "Sign up"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
