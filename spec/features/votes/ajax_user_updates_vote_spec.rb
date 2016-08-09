require 'rails_helper'

RSpec.feature "User updates a vote with an AJAX call;", type: :feature do
  scenario "Vote maintains its state from the original vote", js: true do
    vote = FactoryGirl.create(:vote)
    user = User.where(id: vote.user_id).first
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    sign_in(user)
    find('img.books-index').click

    wait_for_ajax

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
    find('img.books-index').click

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
    find('img.books-index').click

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
    find('img.books-index').click

    click_link "Down Vote"
    wait_for_ajax

    new_vote = Vote.where(id: vote.id).first

    expect(new_vote).to eq(vote)
    expect(new_vote.up_vote).to eq(true)
    expect(new_vote.down_vote).to eq(false)
  end
end
