require 'rails_helper'

RSpec.feature "User views average book rank;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  def unauth_navigate_to_book_details_page
    book
    visit root_path
    find('img.books-index').click

  end

  scenario "An unauthenticated user views the average ranking on the book show page", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    visit root_path
    find('img.books-index').click


    expect(page).to have_content("Average Ranking: #{rank.score}")
  end

  scenario "An authenticated user views the average book ranking on the book show page", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    find('img.books-index').click


    expect(page).to have_content("Average Ranking: #{rank.score}")
  end

  scenario "User views a book with no average ranking", js: true do
    book = FactoryGirl.create(:book)
    visit root_path
    find('img.books-index').click


    expect(page).to_not have_content("Average Ranking")
  end
end
