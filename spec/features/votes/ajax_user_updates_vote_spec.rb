require 'rails_helper'

RSpec.feature "User updates a vote with an AJAX call;", type: :feature do

#   Acceptance Criteria:
# * Vote maintains its state from the original vote
# * User visits books show page where they have already created a vote for a review
#     - links class names have "patch" in them
#     - links have a method of "patch"
# * User successfully updates a vote from "up vote" to "down vote"
# * User successfully updates a vote from "down vote" to "up vote"
# * User views the updated voting status without refreshing the page
# * An unauthenticated user unsuccessfully attempts to update a vote
# * An authenticated user unsuccessfully attempts to update someone else's vote

  scenario "Vote maintains its state from the original vote", js: true do
    user = FactoryGirl.create(:user)
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title

    expect(page).to have_link("Up Vote")
    expect(page).to have_link("Down Vote")
    expect(page).to have_css('a.up-vote-patch-ajax')
    expect(page).to have_css('a.down-vote-patch-ajax')
  end

  scenario "User successfully updates a vote from 'up vote' to 'down vote'", js: true do
    old_vote = FactoryGirl.create(:vote)
    user = User.where(id: old_vote.user_id).first
    review = Review.where(id: old_vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title
    click_link "Down Vote"
    wait_for_ajax
    vote = Vote.all.first

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to eq(false)
    expect(vote.down_vote).to eq(true)
  end

  scenario "User successfully updates a vote from 'down vote' to 'up vote'", js: true do
    old_vote = FactoryGirl.create(:vote, up_vote: false, down_vote: true)
    user = User.where(id: old_vote.user_id).first
    review = Review.where(id: old_vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title
    click_link "Up Vote"
    wait_for_ajax
    vote = Vote.all.first
    
    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to eq(true)
    expect(vote.down_vote).to eq(false)
  end

  scenario "An unauthenticated user unsuccessfully attempts to update a vote", js: true do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to_not have_css('a.up-vote-patch-ajax')
    expect(page).to_not have_css('a.down-vote-patch-ajax')
  end

  scenario "An authenticated user unsuccessfully attempts to update someone else's vote", js: true do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title

    expect(page).to_not have_css('a.up-vote-patch-ajax')
    expect(page).to_not have_css('a.down-vote-patch-ajax')
  end
end
