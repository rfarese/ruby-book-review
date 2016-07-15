require 'rails_helper'

RSpec.feature "User views a books best review;", type: :feature do

  scenario "User views the best review" do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    vote = FactoryGirl.create(:vote, review_id: review.id)
    second_vote = FactoryGirl.create(:vote, review_id: review.id)
    third_vote = FactoryGirl.create(:vote, review_id: second_review.id)
    visit root_path
    click_link review.book.title

    expect(page).to have_content("Best Book Review")
    within("#best-book-review") do
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.description)
      expect(page).to_not have_content(second_review.title)
      expect(page).to_not have_content(second_review.description)
    end
  end

  scenario "User doesn't view a 'Best Book Review' because no one has voted on any reviews" do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    visit root_path
    click_link review.book.title

    expect(page).to_not have_content("Best Book Review")
  end

  scenario "Authenticated user creates a new 'Best Book Review' by adding a vote" do
    review = FactoryGirl.create(:review)
    second_review = FactoryGirl.create(:review, book_id: review.book_id)
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link review.book.title

    within("#review_#{review.id}") do
      click_link "Vote"
    end

    click_link "Up Vote"
    visit book_path(review.book)

    expect(page).to have_content("Best Book Review")
    expect(review.book.best_review).to eq(review)
  end
end
