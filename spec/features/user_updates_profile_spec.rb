require 'rails_helper'

RSpec.feature "User updates profile", type: :feature do

  def signed_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "unauthenticated user doesn't view edit profile link" do
    user = FactoryGirl.create(:user)
    visit root_path

    expect(page).to_not have_content("Edit Profile")
  end

  scenario "authenticated user successfully edits their profile" do
    signed_in_user
    click_link "Edit My Profile"
    fill_in "Email", with: 'newUser@example.com'
    fill_in "user_password", with: "passwording"
    fill_in "Password confirmation", with: "passwording"
    fill_in "Current password", with: "password"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully")
  end

  scenario "authenticated user adds invalid information" do
    signed_in_user
    click_link "Edit My Profile"
    fill_in "Email", with: ''
    fill_in "user_password", with: "passwording"
    fill_in "Password confirmation", with: "passwording"
    fill_in "Current password", with: "passwording"
    click_button "Update"

    expect(page).to have_content("2 errors prohibited this user from being saved")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Current password is invalid")
    expect(page).to_not have_content("Your account has been updated successfully")
  end
end
