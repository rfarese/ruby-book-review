require 'rails_helper'
require 'net/http'

RSpec.feature "User creates a vote;", type: :feature do
  let(:review) { FactoryGirl.create(:review) }
  let(:book) { Book.where(id: review.book_id).first }
  let(:user) { FactoryGirl.create(:user) }

  scenario "User views 'Vote' link on book show page next to each review", js: true do
    review
    book
    visit root_path
    click_link book.title

    expect(page).to have_link("Vote")
  end

  scenario "User navigates to voting page and views 'up vote' and 'down vote' links", js: true do
    review
    book
    visit root_path
    click_link book.title
    click_link "Vote"

    expect(page).to have_content("Create a New Vote")
    expect(page).to have_link("Up Vote")
    expect(page).to have_link("Down Vote")
  end

  scenario "User successfully 'up votes' a review", js: true do
    review
    book
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Vote"
    click_link "Up Vote"
    vote = Vote.where(review_id: review.id, user_id: user.id).first

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to be(true)
    expect(vote.down_vote).to be(false)
    expect(page).to have_content("What a Nice Looking Vote!")
  end

  scenario "User successfully 'down votes' a review", js: true do
    review
    book
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Vote"
    click_link "Down Vote"
    vote = Vote.where(review_id: review.id, user_id: user.id).first

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to be(false)
    expect(vote.down_vote).to be(true)
    expect(page).to have_content("What a Nice Looking Vote!")
  end

  scenario "An unauthenticated user unsuccessfully attempts to vote", js: true do
    review
    book
    visit root_path
    click_link book.title
    click_link "Vote"
    click_link "Up Vote"

    expect(page).to have_content("Join the cool kids! Sign in to cast your vote!")
    expect(Vote.all.size).to eq(0)
  end

  scenario "An authenticated unsuccessfully attempts to vote for a review they've created", js: true do
    review
    book
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Vote"
    click_link "Up Vote"

    expect(page).to have_content("Silly Rabbit! You can't vote for your own review!")
    expect(Vote.all.size).to eq(0)
  end

  # scenario "A user unsuccessfully attempts to create two votes for the same review", js: true do
  #   vote = FactoryGirl.create(:vote)
  #   user = vote.user
  #   sign_in(user)
  #   click_link vote.review.book.title
  #   click_link "Vote"
  #   attributes = {
  #     review_id: vote.review_id,
  #     user_id: user.id,
  #     up_vote: false,
  #     down_vote: true
  #   }
  #   # delete_request = Net::HTTP::Delete.new(review_votes_path(vote.review))
  #   # response = http.request(delete_request)
  #   # Net::HTTP.new("http://localhost:3000/").delete(review_votes_path(vote.review))
  #   # Capybara.current_session.driver.submit :post, review_votes_path(vote.review), attributes
  #   visit book_path(vote.review.book)
  #
  #   expect(Vote.all.size).to eq(1)
  #   expect(vote.up_vote).to be(true)
  #   expect(vote.down_vote).to be(false)
  # end

  scenario "User creates a vote for two different reviews for the same book", js: true do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    user = FactoryGirl.create(:user)
    sign_in(user)

    click_link review.book.title
    within("#review_#{review.id}") do
      click_link "Vote"
    end
    click_link "Up Vote"

    visit root_path
    click_link review.book.title
    within("#review_#{second_review.id}") do
      click_link "Vote"
    end
    click_link "Down Vote"

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
    click_link "Vote"
    click_link "Up Vote"
    visit root_path
    click_link second_review.book.title
    click_link "Vote"
    click_link "Down Vote"

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
