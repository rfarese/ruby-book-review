require 'rails_helper'

RSpec.feature "User creates a vote;", type: :feature do
  let(:review) { FactoryGirl.create(:review) }
  let(:book) { Book.where(id: review.book_id).first }
  let(:user) { FactoryGirl.create(:user) }

  def get_book_and_review
    review
    book
  end

  def navigate_and_vote
    click_link book.title
    click_link "Up Vote"
  end

#   Acceptance Criteria:
#   * User views a "Vote" link next to each review that will bring the user to the voting page
#   * A user can either "Up Vote" or "Down Vote" a review
#   * An unauthenticated user receives an error message when attempting to vote
#   * An authenticated user whose id matches the reviews user id receives an error message
#   * An authenticated user whose id doesn't match the review user id successfully creates a vote for the review

  scenario "User views 'Vote' link on book show page next to each review" do
    review
    book
    visit root_path
    click_link book.title

    expect(page).to have_link("Vote")
  end

  scenario "User navigates to voting page and views 'up vote' and 'down vote' links" do
    review
    book
    visit root_path
    click_link book.title
    click_link "Vote"

    expect(page).to have_content("Create a New Vote")
    expect(page).to have_link("Up Vote")
    expect(page).to have_link("Down Vote")
  end

  scenario "User successfully 'up votes' a review" do
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

  scenario "User successfully 'down votes' a review" do
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

  scenario "An unauthenticated user unsuccessfully attempts to vote" do
    review
    book
    visit root_path
    click_link book.title
    click_link "Vote"
    click_link "Up Vote"

    expect(page).to have_content("Join the cool kids! Sign in to cast your vote!")
    expect(Vote.all.size).to eq(0)
  end

  scenario "An authenticated unsuccessfully attempts to vote for a review they've created" do
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

  scenario "A user unsuccessfully attempts to create two votes for the same review" do
    vote = FactoryGirl.create(:vote)
    user = vote.user
    sign_in(user)
    click_link vote.review.book.title
    click_link "Vote"
    attributes = {
      review_id: vote.review_id,
      user_id: user.id,
      up_vote: false,
      down_vote: true
    }
    Capybara.current_session.driver.submit :post, review_votes_path(vote.review), attributes
    visit book_path(vote.review.book)

    expect(Vote.all.size).to eq(1)
    expect(vote.up_vote).to be(true)
    expect(vote.down_vote).to be(false)
  end
end
