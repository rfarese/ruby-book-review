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
    expect(page).to have_css('a.up-vote-patch-ajax')
    expect(page).to have_css('a.down-vote-patch-ajax')
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
    expect(page).to have_css('a.up-vote-patch-ajax')
    expect(page).to have_css('a.down-vote-patch-ajax')
  end

  scenario "An unauthenticated user unsuccessfully attempts to vote", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Up Vote"

    expect(Vote.all.size).to eq(0)
  end

  scenario "An authenticated unsuccessfully attempts to vote for a review they've created", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Up Vote"

    expect(Vote.all.size).to eq(0)
    expect(page).to have_content("Silly Rabbit!  You can't vote for your own review!")
  end

  scenario "User creates a vote for two different reviews for the same book", js: true do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    user = FactoryGirl.create(:user)
    sign_in(user)

    click_link review.book.title
    within("#review_#{review.id}") do
      click_link "Up Vote"
    end

    visit root_path
    click_link review.book.title
    within("#review_#{second_review.id}") do
      click_link "Down Vote"
    end
    wait_for_ajax

    first_vote = Vote.where(user_id: user.id, review_id: review.id).first
    second_vote = Vote.where(user_id: user.id, review_id: second_review.id).first

    expect(Vote.all.size).to eq(2)
    expect(first_vote).to_not eq(second_vote)
    expect(first_vote.up_vote).to eq(true)
    expect(first_vote.down_vote).to eq(false)
    expect(second_vote.down_vote).to eq(true)
    expect(second_vote.up_vote).to eq(false)
  end

  scenario "User creates a vote for a review for two different books", js: true do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review)
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link review.book.title
    click_link "Up Vote"
    visit root_path
    click_link second_review.book.title
    click_link "Down Vote"
    wait_for_ajax

    first_vote = Vote.where(user_id: user.id, review_id: review.id).first
    second_vote = Vote.where(user_id: user.id, review_id: second_review.id).first

    expect(Vote.all.size).to eq(2)
    expect(first_vote).to_not eq(second_vote)
    expect(first_vote.up_vote).to eq(true)
    expect(first_vote.down_vote).to eq(false)
    expect(second_vote.up_vote).to eq(false)
    expect(second_vote.down_vote).to eq(true)
  end
end
