require 'rails_helper'

RSpec.feature "User views a list of all books", type: :feature do

  def add_books
    Book.create(user_id: 1, title: "First Book Title", author: "First Bob Smith", description: "This is a really good description for a really good book")
    Book.create(user_id: 1, title: "Second Book Title", author: "Second Bob Smith", description: "This is a horrible description for a horrible book")
  end

  scenario "user views the list of books on the home page" do
    add_books
    visit root_path

    expect(page).to have_content("First Book Title")
    expect(page).to have_content("Second Book Title")
  end

  scenario "the list of books includes the book title and the book author" do
    add_books
    visit root_path
    save_and_open_page

    expect(page).to have_content("First Book Title")
    expect(page).to have_content("First Bob Smith")
    expect(page).to have_content("Second Book Title")
    expect(page).to have_content("Second Bob Smith")
  end
end
