require 'rails_helper'

RSpec.feature "User edits a vote;", type: :feature do

  scenario "User views the ability to edit their vote on the voting page", js: true do
    vote = FactoryGirl.create(:vote)
    book = vote.review.book
    user = vote.user
    sign_in(user)
    click_link book.title
    click_link "Vote"

    expect(page).to have_content("Edit Your Vote")
  end

  scenario "User views their current voting status for a review they'd previously up voted", js: true do
    vote = FactoryGirl.create(:vote)
    book = vote.review.book
    user = vote.user
    sign_in(user)
    click_link book.title
    click_link "Vote"

    expect(page).to have_content("Voting Status: Up Voted")
  end

  scenario "User views their current voting status for a review they'd previously down voted", js: true do
    vote = FactoryGirl.create(:vote, up_vote: false, down_vote: true)
    user = vote.user
    sign_in(user)
    click_link vote.review.book.title
    click_link "Vote"

    expect(page).to have_content("Voting Status: Down Voted")
  end


  scenario "User successfully changes their vote from up vote to down vote", js: true do
    old_vote = FactoryGirl.create(:vote)
    user = old_vote.user
    sign_in(user)
    click_link old_vote.review.book.title
    click_link "Vote"
    click_link "Down Vote"
    new_vote = Vote.where(user_id: user.id, review_id: old_vote.review_id).first

    expect(new_vote.down_vote).to eq(true)
    expect(new_vote.up_vote).to eq(false)
    expect(Vote.all.size).to eq(1)
  end

  scenario "User successfully changes their vote from down vote to up vote", js: true do
    old_vote = FactoryGirl.create(:vote, up_vote: false, down_vote: true)
    user = old_vote.user
    sign_in(user)
    click_link old_vote.review.book.title
    click_link "Vote"
    click_link "Up Vote"
    new_vote = Vote.where(user_id: user.id, review_id: old_vote.review_id).first

    expect(new_vote.down_vote).to eq(false)
    expect(new_vote.up_vote).to eq(true)
    expect(Vote.all.size).to eq(1)
  end

  scenario "Unauthenticated user unsuccessfully attempts to edit a vote", js: true do
    vote = FactoryGirl.create(:vote)
    visit root_path
    click_link vote.review.book.title
    click_link "Vote"
    click_link "Down Vote"

    expect(vote.down_vote).to eq(false)
    expect(vote.up_vote).to eq(true)
    expect(Vote.all.size).to eq(1)
    expect(page).to have_content("Join the cool kids! Sign in to cast your vote!")
  end

  scenario "Authenticated user views voting status before they've created a vote", js: true do
    review = FactoryGirl.create(:review)
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link review.book.title
    click_link "Vote"

    expect(page).to have_content("Voting Status: None")
  end

  scenario "Unauthenticated user doesn't view a vote status", js: true do
    vote = FactoryGirl.create(:vote)
    visit root_path
    click_link vote.review.book.title
    click_link "Vote"

    expect(page).to have_content("Voting Status: None")
    expect(vote.up_vote).to eq(true)
  end
end
