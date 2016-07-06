require 'rails_helper'

RSpec.feature "User creates a vote", type: :feature do
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

  scenario "user views up vote and down vote buttons on the book details page" do
    get_book_and_review
    visit root_path
    click_link book.title

    expect(page).to have_content("Up Vote")
    expect(page).to have_content("Down Vote")
  end

  scenario "authenticated user successfully votes for a review they did not create" do
    get_book_and_review
    sign_in(user)
    navigate_and_vote
    vote = Vote.where(user_id: user.id).first

    expect(vote.up_vote).to eq(true)
    expect(vote.down_vote).to eq(false)
    expect(vote.review_id).to eq(review.id)
  end

  scenario "authenticated user unsuccessfully votes for a review they created" do
    get_book_and_review
    user = User.where(id: review.user_id).first
    sign_in(user)
    navigate_and_vote

    expect(page).to have_content("You can't vote for your own review")
  end

  scenario "unauthenticated user unsuccessfully votes for a review" do
    get_book_and_review
    visit root_path
    navigate_and_vote

    expect(page).to have_content("Sign in before you vote!")
  end
end
