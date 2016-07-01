require 'rails_helper'

RSpec.feature "User deletes a review", type: :feature do

  def sign_in(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

#   Acceptance Criteria:
#     * The review delete functionality is located on the review edit page
#     * an unauthenticated user will receive an error notice if they attempt to delete a review
#     * an authenticated user successfully deletes a review they've created
#     * an authenticated user receives an error message when attempting to delete a review they didn't create

  scenario "review delete link is located on the review edit page" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Edit Review"

    expect(page).to have_content("Delete Review")
  end

  scenario "an authenticated user successfully deletes a review they've created" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Edit Review"
    click_link "Delete Review"

    expect(page).to have_content("You've successfully deleted your review")
  end

  scenario "an unauthenticated user unsuccessfully attempts to delete a review" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    visit root_path
    click_link book.title
    click_link "Edit Review"
    click_link "Delete Review"

    expect(page).to have_content("You must be signed in to delete a review")
  end

  scenario "an authenticated user can't delete a review they haven't created" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Edit Review"
    click_link "Delete Review"

    expect(page).to have_content("You can only delete a review you've created")
  end
end
