require 'rails_helper'

RSpec.feature "User views a books details", type: :feature do

  def navigate_to_book_page
    book = FactoryGirl.create(:book)
    visit root_path
    find('img.books-index').click

    book
  end

  scenario "user navigates to book show page from root path", js: true do
    navigate_to_book_page

    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
  end

  scenario "user views details about book", js: true do
    book = navigate_to_book_page

    expect(page).to have_content(book.title.upcase)
    expect(page).to have_content(book.author)
    expect(page).to have_content(book.description)
  end

  scenario "user views the books average ranking", js: true do
    rank = FactoryGirl.create(:rank, score: 1)
    second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 2)
    third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 1)
    book = Book.where(id: rank.book_id).first

    visit root_path
    find('img.books-index').click


    expect(page).to have_content("Average Ranking: 1.3")
  end
end
