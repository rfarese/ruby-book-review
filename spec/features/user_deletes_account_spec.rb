# Acceptance Criteria:
# * unauthenticated users cant delete an account (no deleting other users profiles)
# * There should be a "Cancel My Account" link on the Edit User page
# * After clicking on the "Delete My Account" link, the user should receive a notice asking them if they are sure that they'd like to delete their account.  This is to prevent people from accidentally deleting their account
# * If they are sure they'd like to delete the account, then the user will receive a notice saying "Your account has successfully been deleted."

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

  scenario "authenticated user views the link to cancel their account"

  scenario "authenticated user recieves a warning that their about to delete their account"

  scenario "authenticated user successfully deletes their account"

end
