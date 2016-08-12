require 'rails_helper'

RSpec.feature "User searches for a book by title;", type: :feature do
  let(:book) { FactoryGirl.create(:book) }

  def visit_root_complete_search
    visit root_path
    within("#search-form") do
      fill_in "search", with: book.title
    end
    click_button "Go"
  end

  scenario "User views the search bar in navigation bar" do
    visit root_path

    expect(page).to have_css("#search-form")
  end

  scenario "User views search results (book title) on books show page" do
    book
    second_book = FactoryGirl.create(:book)
    visit_root_complete_search

    expect(page).to have_css("a[href='/books/#{book.id}']")
  end

  scenario "User navigates from search results page to the books show page", js: true do
    book
    visit_root_complete_search
    find('img.books-index').click

    expect(page).to have_content(book.title.upcase)
    expect(page).to have_content(book.author)
    expect(page).to have_content(book.description)
  end
end
