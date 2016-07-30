require 'rails_helper'

RSpec.feature "User deletes a vote;", type: :feature do

  scenario "An authenticated user views the 'Delete' link on the voting page for a review they've already voted on", js: true do
    vote = FactoryGirl.create(:vote)
    user = vote.user
    sign_in(user)
    click_link vote.review.book.title
    click_link "Vote"

    expect(page).to have_link("Delete Vote")
  end

  scenario "An authenticated user doesn't view 'Delete' link if they have't voted for that review", js: true do
    vote = FactoryGirl.create(:vote)
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link vote.review.book.title
    click_link "Vote"

    expect(page).to_not have_link("Delete Vote")
  end

  scenario "An unauthenticated user doesn't view the 'Delete' link", js: true do
    vote = FactoryGirl.create(:vote)
    visit root_path
    click_link vote.review.book.title
    click_link "Vote"

    expect(page).to_not have_link("Delete Vote")
  end

  scenario "User successfully deletes a vote", js: true do
    vote = FactoryGirl.create(:vote)
    user = vote.user
    sign_in(user)
    click_link vote.review.book.title
    click_link "Vote"
    click_link "Delete Vote"

    expect(Vote.all.size).to eq(0)
    expect(page).to have_content("Hasta la vista...vote!")
  end

  scenario "A user deletes one of two votes for two different reviews on the same book", js: true do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    vote = FactoryGirl.create(:vote, review_id: review.id)
    second_vote = FactoryGirl.create(:vote, review_id: second_review.id, user_id: vote.user_id)
    sign_in(vote.user)
    click_link review.book.title
    within("#review_#{review.id}") do
      click_link "Vote"
    end
    click_link "Delete Vote"

    expect(Vote.all.size).to eq(1)
    expect(vote.user).to eq(second_vote.user)
    expect(review.book).to eq(second_review.book)
  end

  scenario "A user deletes one of two votes for different reviews on two different books", js: true do
    vote = FactoryGirl.create(:vote)
    second_vote = FactoryGirl.create(:vote, user_id: vote.user_id)
    sign_in(vote.user)
    click_link vote.review.book.title
    click_link "Vote"
    click_link "Delete Vote"

    expect(Vote.all.size).to eq(1)
  end

  # scenario "An unauthenticated user unsuccessfully attempts to delete a vote", js: true do
  #   vote = FactoryGirl.create(:vote)
  #   visit root_path
  #   click_link vote.review.book.title
  #   click_link "Vote"
  #   attributes = {
  #     review_id: vote.review_id,
  #     user_id: vote.user_id,
  #     id: vote.id
  #   }
  #   Capybara.current_session.driver.submit :delete, review_vote_path(vote.review, vote), attributes
  #   visit book_path(vote.review.book)
  #
  #   expect(Vote.all.size).to eq(1)
  # end

  # scenario "An authenticated user unsuccessfully attempts to delete someone elses vote", js: true do
  #   vote = FactoryGirl.create(:vote)
  #   user = FactoryGirl.create(:user)
  #   sign_in(user)
  #   click_link vote.review.book.title
  #   click_link "Vote"
  #   attributes = {
  #     review_id: vote.review_id,
  #     user_id: vote.user_id,
  #     id: vote.id
  #   }

  #   Capybara.current_session.driver.submit :delete, review_vote_path(vote.review, vote), attributes
  #   visit book_path(vote.review.book)
  #
  #   expect(Vote.all.size).to eq(1)
  # end
end
