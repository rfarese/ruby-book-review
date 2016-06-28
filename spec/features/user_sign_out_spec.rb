require 'rails_helper'

RSpec.feature "User signs out of the system", type: :feature do

  def signed_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "authenticated user views sign out link" do
    signed_in_user

    expect(page).to have_content("Sign Out")
  end

  scenario "user successfully signs out of the system" do
    signed_in_user
    click_link "Sign Out"

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Signed out successfully")
    expect(page).to_not have_content("Sign Out")
  end
end
