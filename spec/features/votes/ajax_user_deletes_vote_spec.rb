require 'rails_helper'

RSpec.feature "User deletes a vote with an AJAX call;", type: :feature do
  scenario "User views the ability to delete a vote on the books show page", js: true do
    vote = FactoryGirl.create(:vote)
    user = User.where(id: vote.user_id).first
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title

    expect(page).to have_link("Delete Vote")
  end

  scenario "User successfully deletes a vote", js: true do
    vote = FactoryGirl.create(:vote)
    user = User.where(id: vote.user_id).first
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title
    click_link "Delete Vote"
    wait_for_ajax

    expect(Vote.all.size).to eq(0)
    expect(page).to_not have_link("Delete Vote")
    expect(page).to have_css('a.up-vote-post-ajax')
  end

  scenario "Unauthenticated user unsuccessfully attempts to delete a vote", js: true do
    vote = FactoryGirl.create(:vote)
    user = FactoryGirl.create(:user)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    click_link book.title

    expect(page).to_not have_link("Delete Vote")
  end
end
