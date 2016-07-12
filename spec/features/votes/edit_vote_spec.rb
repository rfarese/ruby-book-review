require 'rails_helper'

RSpec.feature "User edits a vote;", type: :feature do

# New Acceptance Criteria: 
  # * User views their current voting status for that review on the voting page
  #     * If they have voted, display whether they if they upvoted or downvoted the review
  #     * If they upvoted:
  #       * display "You upvoted this review"
  #       * display a link "Down Vote" under the heading "Edit Your Vote"
  #       * display "Delete Vote" link
  #     * If they downvoted:
  #       * display "You downvoted this review"
  #       * display a link "Up Vote" under the heading "Edit Your Vote"
  #       * display "Delete Vote" link

  scenario "authenticated user successfully changes a vote" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Up Vote"
    click_link "Down Vote"
    vote = Vote.where(user_id: user.id).first

    expect(vote.up_vote).to eq(false)
    expect(vote.down_vote).to eq(true)
    expect(vote.review_id).to eq(review.id)
  end

  scenario "An unauthenticated user can not change a vote" do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Down Vote"

    expect(page).to have_content("You must be signed in to vote")
  end

  scenario "An authenticated user can not change a vote for a review they've created" do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Down Vote"

    expect(page).to have_content("You can't vote for your own review")
  end
end
