require 'rails_helper'

RSpec.feature "User deletes a vote", type: :feature do
  let(:vote) { FactoryGirl.create(:vote) }
  let(:review) { Review.where(id: vote.review_id).first }
  let(:book) { Book.where(id: review.book_id).first }

# Acceptance Criteria:
  # User views the "Delete" link on the voting page
  # If a user has already created a vote for that review:
    # disply "Delete" link
  # user successfully deletes the vote
  # unauthenticated user unsuccessfully deletes the vote
  # authenticated user unsuccessfully deletes a vote they didn't create 

  def get_vote_review_and_book
    vote
    review
    book
  end

  def navigate_and_delete_vote
    click_link book.title
    click_link "Delete Vote"
  end

  scenario "An authenticated user deletes a vote for a review that they haven't created" do
    get_vote_review_and_book
    user = User.where(id: vote.user_id).first
    sign_in(user)
    navigate_and_delete_vote

    expect(page).to have_content("Your vote has been removed")
    expect(Vote.all.size).to eq(0)
  end

  scenario "An authenticated user can not delete a vote for a review that they have created" do
    get_vote_review_and_book
    user = User.where(id: review.user_id).first
    sign_in(user)
    navigate_and_delete_vote

    expect(page).to have_content("You can not delete a vote for a review you created")
    expect(Vote.all.size).to eq(1)
  end

  scenario "An unauthenticated user can not delete a vote" do
    get_vote_review_and_book
    visit root_path
    navigate_and_delete_vote

    expect(page).to have_content("You must be signed in to delete a vote")
    expect(Vote.all.size).to eq(1)
  end
end
