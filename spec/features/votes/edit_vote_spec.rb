require 'rails_helper'

RSpec.feature "User edits a vote;", type: :feature do

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
