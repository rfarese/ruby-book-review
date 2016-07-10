require 'rails_helper'

RSpec.feature "User deletes account", type: :feature do

  scenario "unauthenticated user can't access the edit profile page to delete an account" do
    visit root_path

    expect(page).to_not have_content("Edit Profile")
  end

  scenario "authenticated user successfully deletes their account" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link "Edit Profile"
    click_button "Cancel my account"

    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
    expect(User.all.size).to eq(0)
  end
end
