require 'rails_helper'

RSpec.feature "User signs out of the system", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario "authenticated user views sign out link" do
    sign_in(user)

    expect(page).to have_content("Sign Out")
  end

  scenario "user successfully signs out of the system" do
    sign_in(user)
    click_link "Sign Out"

    expect(page).to have_content("Sign In")
    expect(page).to have_content("Signed out successfully")
    expect(page).to_not have_content("Sign Out")
  end
end
