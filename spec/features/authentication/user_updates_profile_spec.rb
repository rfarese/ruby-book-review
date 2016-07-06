require 'rails_helper'

RSpec.feature "User updates profile", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  def sign_in_and_navigate
    sign_in(user)
    click_link "Edit Profile"
  end

  def fill_in_new_password
    fill_in "user_password", with: "passwording"
    fill_in "Password confirmation", with: "passwording"
  end

  scenario "unauthenticated user doesn't view edit profile link" do
    visit root_path

    expect(page).to_not have_content("Edit Profile")
  end

  scenario "authenticated user successfully edits their profile" do
    sign_in_and_navigate
    fill_in "Email", with: 'newUser@example.com'
    fill_in_new_password
    fill_in "Current password", with: "password"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully")
  end

  scenario "authenticated user adds invalid information" do
    sign_in_and_navigate
    fill_in "Email", with: ''
    fill_in_new_password
    fill_in "Current password", with: "passwording"
    click_button "Update"

    expect(page).to have_content("2 errors prohibited this user from being saved")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Current password is invalid")
    expect(page).to_not have_content("Your account has been updated successfully")
  end
end
