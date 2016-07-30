require 'rails_helper'

RSpec.feature "User views a list of all books;", type: :feature do

  def add_books(num)
    books = []
    num.times { books << FactoryGirl.create(:book) }
    books
  end

  scenario "user views the list of books on the home page", js: true do
    books = add_books(2)
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books.last.title)
  end
end
