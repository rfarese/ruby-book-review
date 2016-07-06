require 'rails_helper'

RSpec.feature "User updates a review", type: :feature do
  let(:review) { FactoryGirl.create(:review) }
  let(:book) { Book.where(id: review.book_id).first }
  let(:review_creating_user) { User.where(id: review.user_id).first }
  let(:no_review_creating_user) { FactoryGirl.create(:user) }

  def get_book_and_review
    review
    book
  end

  def navigate_and_edit_review
    click_link book.title
    click_link "Edit Review"
    fill_in "Title", with: "Edited Review Title"
    fill_in "Description", with: "Edited Review Description"
    click_button "Save"
  end

  scenario "an unauthenticated unsuccesfully attemtps to edit a review" do
    get_book_and_review
    visit root_path
    navigate_and_edit_review

    expect(page).to have_selector("h1", text: "Edit Review")
    expect(page).to have_content("You must be signed in to edit a review")
  end

  scenario "an authenticated user successfully updates a review" do
    get_book_and_review
    sign_in(review_creating_user)
    navigate_and_edit_review

    expect(page).to have_content("You've successfully updated your review!")
    expect(page).to have_content("Edited Review Title")
    expect(page).to have_content("Edited Review Description")
  end

  scenario "an authenticated users id doesn't match the user id of the review creator" do
    get_book_and_review
    sign_in(no_review_creating_user)
    navigate_and_edit_review

    expect(page).to have_content("You can only edit a review you've created.")
  end
end
