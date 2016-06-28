require 'rails_helper'

RSpec.feature "User deletes account", type: :feature do

  def signed_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "unauthenticated user can't access the edit profile page to delete an account" do
    visit root_path

    expect(page).to_not have_content("Edit Profile")
  end

  scenario "authenticated user successfully deletes their account" do
    signed_in_user
    click_link "Edit Profile"
    click_button "Cancel my account"

    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
  end
end
