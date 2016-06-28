require 'rails_helper'

RSpec.feature "User creates a new book", type: :feature do

  def signed_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "user navigates to the new book page" do
    visit root_path
    click_link "Add a New Book"

    expect(page).to have_content("Add a New Book to Review")
    expect(page).to have_content("Title")
    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
    expect(page).to have_content("Book Cover Photo")
  end

  scenario "an unauthenticated user can not create a new book"

  scenario "authenticated user successfully creates a new book"

  scenario "authenticated user doesnt provide valid and required information to create a new book"

end
