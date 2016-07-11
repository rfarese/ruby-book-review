require 'rails_helper'

RSpec.feature "User views a list of all books;", type: :feature do

  def add_books(num)
    books = []
    num.times { books << FactoryGirl.create(:book) }
    books
  end

  scenario "user views the list of books on the home page" do
    books = add_books(2)
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books.last.title)
  end

  scenario "the list of books includes the book title and the book author" do
    books = add_books(2)
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books.first.author)
    expect(page).to have_content(books.last.title)
    expect(page).to have_content(books.last.author)
  end

  scenario "User only views 25 books per page" do
    books = add_books(30)
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books[24].title)
    expect(page).to_not have_content(books[25].title)
  end

  scenario "User can navigate to additional pages to view additional results" do
    books = add_books(30)
    visit root_path
    click_link "2"

    expect(page).to have_content(books[25].title)
    expect(page).to_not have_content(books[24].title)
  end
end
