require 'rails_helper'

RSpec.feature "User deletes a vote", type: :feature do

  def sign_in(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  scenario "An authenticated user deletes a vote for a review that they haven't created" do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    user = User.where(id: vote.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Delete Vote"

    expect(page).to have_content("Your vote has been removed")
    expect(Vote.all.size).to eq(0)
  end

  scenario "An authenticated user can not delete a vote for a review that they have created" do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    user = User.where(id: review.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Delete Vote"
  
    expect(page).to have_content("You can not delete a vote for a review you created")
    expect(Vote.all.size).to eq(1)
  end

  scenario "An unauthenticated user can not delete a vote" do
    vote = FactoryGirl.create(:vote)
    review = Review.where(id: vote.review_id).first
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title
    click_link "Delete Vote"

    expect(page).to have_content("You must be signed in to delete a vote")
    expect(Vote.all.size).to eq(1)
  end
end
