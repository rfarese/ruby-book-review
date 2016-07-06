require 'rails_helper'

RSpec.feature "User views a list of all books", type: :feature do

  def add_books
    [FactoryGirl.create(:book), FactoryGirl.create(:book)]
  end

  scenario "user views the list of books on the home page" do
    books = add_books
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books.last.title)
  end

  scenario "the list of books includes the book title and the book author" do
    books = add_books
    visit root_path

    expect(page).to have_content(books.first.title)
    expect(page).to have_content(books.first.author)
    expect(page).to have_content(books.last.title)
    expect(page).to have_content(books.last.author)
  end
end
