require 'rails_helper'

RSpec.feature "User views a books details", type: :feature do

  def navigate_to_book_page
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title
    book
  end

  scenario "user navigates to book show page from root path" do
    navigate_to_book_page

    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
  end

  scenario "user views details about book" do
    book = navigate_to_book_page

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.author)
    expect(page).to have_content(book.description)
  end

  scenario "user views the books average ranking" do
    rank = FactoryGirl.create(:rank, rank: 1)
    second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 2)
    third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 1)
    book = Book.where(id: rank.book_id).first

    visit root_path
    click_link book.title

    expect(page).to have_content("Average Ranking: 1.3")
  end
end
