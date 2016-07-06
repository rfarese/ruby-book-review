require 'rails_helper'

RSpec.feature "User deletes a review", type: :feature do
  let(:review) { FactoryGirl.create(:review) }
  let(:book) { Book.where(id: review.book_id).first }
  let(:review_creating_user) { User.where(id: review.user_id).first }
  let(:no_review_creating_user) { FactoryGirl.create(:user) }

  def get_book_and_review
    review
    book
  end

  def navigate_and_delete_review
    click_link book.title
    click_link "Edit Review"
    click_link "Delete Review"
  end

  scenario "review delete link is located on the review edit page" do
    get_book_and_review
    visit root_path
    click_link book.title
    click_link "Edit Review"

    expect(page).to have_content("Delete Review")
  end

  scenario "an authenticated user successfully deletes a review they've created" do
    get_book_and_review
    sign_in(review_creating_user)
    navigate_and_delete_review

    expect(page).to have_content("You've successfully deleted the review")
  end

  scenario "an unauthenticated user unsuccessfully attempts to delete a review" do
    get_book_and_review
    visit root_path
    navigate_and_delete_review

    expect(page).to have_content("You must be signed in to delete a review")
  end

  scenario "an authenticated user can't delete a review they haven't created" do
    get_book_and_review
    sign_in(no_review_creating_user)
    navigate_and_delete_review

    expect(page).to have_content("You can only delete a review you've created")
  end
end
