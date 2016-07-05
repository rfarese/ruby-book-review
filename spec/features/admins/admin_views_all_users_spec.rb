require 'rails_helper'

RSpec.feature "Admin views all system users", type: :feature do

  scenario "Admin user accesses page that lists all the users of the system" do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    sign_in(admin)
    click_link "User Profiles"

    expect(page).to have_content("All System Users")
    expect(page).to have_content("#{user.first_name} #{user.last_name}")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Role: #{user.role}")
  end

  scenario "an unauthenticated user doesn't view link to access the list of users" do
    visit root_path

    expect(page).to_not have_content("User Profiles")
  end

  scenario "An unauthenticated user cannot access this list of users" do
    visit users_path

    expect(page.status_code).to eq(404)
  end

  scenario "An non-admin authenticated user does not view the link to access the list of users" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    expect(page).to_not have_content("User Profiles")
  end

  scenario "A non-admin authenticated user cannot access the list of users" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit users_path

    expect(page.status_code).to eq(404)
  end
end
