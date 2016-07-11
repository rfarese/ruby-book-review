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

#   Acceptance Criteria:
  # * A user only views 15 books per page
  # * This is true on both the books view page (all books) and on the books search results page
  # * A user can select the next page which will display the next set of results (i.e. page 1 will have books 1-15, page 2 will have books 16-30, etc.)

  scenario "User only views 15 books per page"

  scenario "User can navigate to additional pages to view additional results"

end











































#
