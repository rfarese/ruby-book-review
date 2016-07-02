require 'rails_helper'

RSpec.feature "User creates a vote", type: :feature do

  def sign_in(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  scenario "user views up vote and down vote buttons on the book details page" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to have_content("Up Vote")
    expect(page).to have_content("Down Vote")
  end

  scenario "authenticated user successfully votes for a review they did not create" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Up Vote"
    vote = Vote.where(user_id: user.id).first

    expect(vote.up_vote).to eq(true)
    expect(vote.down_vote).to eq(false)
    expect(vote.review_id).to eq(review.id)
  end

  scenario "authenticated user unsuccessfully votes for a review they created" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Up Vote"

    expect(page).to have_content("You can't vote for your own review")
  end

  scenario "unauthenticated user unsuccessfully votes for a review" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Up Vote"

    expect(page).to have_content("Sign in before you vote!")
  end
end
