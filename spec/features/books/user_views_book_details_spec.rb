require 'rails_helper'

RSpec.feature "User views a books details", type: :feature do

  def add_book
    Book.create(user_id: 1, title: "First Book Title", author: "First Bob Smith", description: "This is a really good description for a really good book")
  end

  scenario "user navigates to book show page from root path" do
    add_book
    visit root_path
    click_link "First Book Title"

    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
  end

  scenario "user views details about book" do
    add_book
    visit root_path
    click_link "First Book Title"

    expect(page).to have_content("First Book Title")
    expect(page).to have_content("First Bob Smith")
    expect(page).to have_content("This is a really good description for a really good book")
  end
end
