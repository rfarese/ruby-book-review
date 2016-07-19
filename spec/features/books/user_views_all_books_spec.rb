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

  # For the next two tests, the book index page is now being displayed with React
    # I'm not doing more pagination in React at this point in the project...

  # scenario "User only views 25 books per page", js: true do
  #   books = add_books(30)
  #   visit root_path
  #
  #   expect(page).to have_content(books.first.title)
  #   expect(page).to have_content(books[24].title)
  #   expect(page).to_not have_content(books[25].title)
  # end

  # scenario "User can navigate to additional pages to view additional results", js: true do
  #   books = add_books(30)
  #   visit root_path
  #   page.save_screenshot('lib/screenshot.png', :full => true)
  #   click_link "2"
  #
  #   expect(page).to have_content(books[25].title)
  #   expect(page).to_not have_content(books[20].title)
  # end
end
