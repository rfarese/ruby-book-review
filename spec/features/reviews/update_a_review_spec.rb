require 'rails_helper'

RSpec.feature "User updates a review", type: :feature do

  def sign_in_user(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  scenario "an unauthenticated unsuccesfully attemtps to edit a review" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Edit Review"

    fill_in "Title", with: "Edited Review Title"
    fill_in "Description", with: "Edited Review Description"
    click_button "Save"

    expect(page).to have_selector("h1", text: "Edit Review")
    expect(page).to have_content("You must be signed in to edit a review")
  end

  scenario "an authenticated user successfully updates a review" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in_user(user)
    click_link book.title
    click_link "Edit Review"

    fill_in "Title", with: "Edited Review Title"
    fill_in "Description", with: "Edited Review Description"
    click_button "Save"

    expect(page).to have_content("You've successfully updated your review!")
    expect(page).to have_content("Edited Review Title")
    expect(page).to have_content("Edited Review Description")
  end

  scenario "an authenticated users id doesn't match the user id of the review creator" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in_user(user)
    click_link book.title
    click_link "Edit Review"

    fill_in "Title", with: "Edited Review Title"
    fill_in "Description", with: "Edited Review Description"
    click_button "Save"

    expect(page).to have_content("You can only edit a review you've created.")
  end
end
