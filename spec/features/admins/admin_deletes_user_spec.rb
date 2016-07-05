require 'rails_helper'

RSpec.feature "Admin views all system users", type: :feature do

  scenario "Admin views a 'delete' link next to each users name" do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    sign_in(admin)
    click_link "User Profiles"

    expect(page).to have_content("Delete User")
  end

  scenario 'Admin successfully deletes a users account' do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    sign_in(admin)
    click_link "User Profiles"

    within(:css, "ul#user_#{user.id}") do
      click_link "Delete User"
    end

    expect(User.all.size).to eq(1)
    expect(page).to have_content("You've successfully removed the user")
  end
end















#
