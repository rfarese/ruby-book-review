require 'rails_helper'

RSpec.feature "User ranks a book;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  def unauth_navigate_to_book_details_page
    book
    visit root_path
    click_link book.title
  end

  def navigate_and_choose_rank
    click_link "Rank This Book"
    choose("5")
    click_button "Save Rank"
  end

  scenario "User views ranking capabilities on the book show page" do
    unauth_navigate_to_book_details_page

    expect(page).to have_content("Rank This Book")
  end

  scenario "user views possible rankings for a book (1, 2, 3, 4, 5)" do
    unauth_navigate_to_book_details_page
    click_link "Rank This Book"

    expect(page).to have_content("Rank #{book.title}")
  end

  scenario "An authenticated user successfully ranks a book" do
    book
    sign_in(user)
    click_link book.title
    navigate_and_choose_rank

    expect(page).to have_content("Your book ranking has been saved!")
    expect(Rank.all.size).to eq(1)
  end

  scenario "An unauthenticated user unsuccessfully attempts to rank a book" do
    unauth_navigate_to_book_details_page
    navigate_and_choose_rank

    expect(page).to have_content("You must be signed in to rank a book")
    expect(Rank.all.size).to eq(0)
  end
end