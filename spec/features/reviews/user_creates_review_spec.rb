require 'rails_helper'

RSpec.feature "User creates a review", type: :feature do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  def navigate_and_fill_in_review
    find('img.books-index').click

    fill_in "Title", with: "This is a wonderful book!"
    fill_in "Description", with: "Even though its a little lengthy at times, the ending is awesome!"
    click_button "Submit Review"
  end

  scenario "user views review creation section on the book details page", js: true do
    book
    visit root_path
    find('img.books-index').click


    expect(page).to have_content("Add a Review")
  end

  scenario "authenticated user successfully creates a review", js: true do
    book
    sign_in(user)
    navigate_and_fill_in_review

    expect(page).to have_content("You've successfully added your new review!")
    expect(Review.all.size).to eq(1)
  end

  scenario "unauthenticated user recieves an error message when attempting to creating a new review", js: true do
    book
    visit root_path
    navigate_and_fill_in_review

    expect(page).to have_content("You must be signed in to create a book review")
    expect(Review.all.size).to eq(0)
  end

  scenario "user views the title and the description of all existing reviews under the book details", js: true do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    find('img.books-index').click


    expect(page).to have_content(review.title)
    expect(page).to have_content(review.description)
  end
end
