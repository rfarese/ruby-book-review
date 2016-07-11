require 'rails_helper'

RSpec.feature "User views all reviews associated with a book;", type: :feature do

  def add_reviews(book, num)
    reviews = []
    num.times { reviews << FactoryGirl.create(:review, book_id: book.id) }
    reviews
  end

  scenario "User views a book's reviews on the book's show page" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to have_content("Book Reviews")
  end

  scenario "User views the book reivews title and description" do
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    visit root_path
    click_link book.title

    expect(page).to have_content(review.title)
    expect(page).to have_content(review.description)
  end

  scenario "User only views 25 reviews per page" do
    book = FactoryGirl.create(:book)
    reviews = add_reviews(book, 30)
    visit root_path
    click_link book.title

    expect(page).to have_content(reviews.first.title)
    expect(page).to_not have_content(reviews[25].title)
  end

  scenario "User navigates to additional pages to view the next set of reviews" do
    book = FactoryGirl.create(:book)
    reviews = add_reviews(book, 30)
    visit root_path
    click_link book.title
    click_link "2"

    expect(page).to_not have_content(reviews.first.title)
    expect(page).to have_content(reviews[25].title)
  end
end
