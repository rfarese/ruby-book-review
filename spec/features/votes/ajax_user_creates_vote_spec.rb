require 'rails_helper'

RSpec.feature "User creates a vote with an AJAX call;", type: :feature do

  scenario "User views 'Vote Up' and 'Vote Down' link on book show page next to each review", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to have_link("Up Vote")
    expect(page).to have_link("Down Vote")
  end

  scenario "User successfully 'up votes' a review", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Up Vote"
    wait_for_ajax
    vote = Vote.all.first

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to eq(true)
    expect(vote.down_vote).to eq(false)
    expect(page).to have_content("What a Nice Looking Vote!")
    # expect(page).to have_css('a.up-vote-patch-ajax')
    # expect(page).to have_css('a.down-vote-patch-ajax')
  end

  scenario "User successfully 'down votes' a review", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Down Vote"
    wait_for_ajax
    vote = Vote.all.first

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to eq(false)
    expect(vote.down_vote).to eq(true)
    expect(page).to have_content("What a Nice Looking Vote!")
    # expect(page).to have_css('a.up-vote-patch-ajax')
    # expect(page).to have_css('a.down-vote-patch-ajax')
  end

  scenario "An unauthenticated user unsuccessfully attempts to vote", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Up Vote"

    expect(Vote.all.size).to eq(0)
    # expect(page).to have_content("")
  end

  scenario "An authenticated unsuccessfully attempts to vote for a review they've created", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Up Vote"

    expect(Vote.all.size).to eq(0)
    # expect(page).to have_content("")
  end

  scenario "User creates a vote for two different reviews for the same book"

  scenario "User creates a vote for a review for two different books"
end
