require 'rails_helper'

RSpec.feature "User creates a review", type: :feature do

  def sign_in_user(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

#   Acceptance Criteria:
#     * User successfully navigates to the review creation page from the book details page
#     * An unauthenticated user will receive an error message if they attempt to create a review
#     * The reviews will populate under the book details
#     * The reviews will have a title, description, and show the users first name that created the review

  scenario "user views review creation section on the book details page" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title

    expect(page).to have_content("Add a Review")
  end

  scenario "authenticated user successfully creates a review" do
  current_user = FactoryGirl.create(:user)
  book = FactoryGirl.create(:book)

  sign_in_user(current_user)
  click_link book.title

  fill_in "Title", with: "This is a wonderful book!"
  fill_in "Description", with: "Even though its a little lengthy at times, the ending is awesome!"
  click_button "Submit Review"

  expect(page).to have_content("You've successfully added your new review!")
  expect(Review.all.size).to eq(1)
  end

  scenario "unauthenticated user recieves an error message when attempting to creating a new review" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title

    fill_in "Title", with: "This is a wonderful book!"
    fill_in "Description", with: "Even though its a little lengthy at times, the ending is awesome!"
    click_button "Submit Review"

    expect(page).to have_content("You must be signed in to create a book review")
    expect(Review.all.size).to eq(0)
  end

  scenario "user views the title and the description of all existing reviews under the book details" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to have_content(review.title)
    expect(page).to have_content(review.description)
  end
end
