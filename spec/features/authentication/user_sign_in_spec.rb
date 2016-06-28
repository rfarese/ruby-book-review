require 'rails_helper'

RSpec.feature "User sign in", type: :feature do
  scenario "User sees link to sign in if the user is unauthenticated" do
    user = FactoryGirl.create(:user)
    visit root_path

    expect(page).to have_content("Sign In")
  end

  scenario "a returning user provides all valid information when signing in" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")
  end

  scenario "user doesn't provide valid credentials" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: "youremail"
    fill_in "Password", with: "mypassword"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("Sign In")
    expect(page).to_not have_content("Sign Out")
  end
end
