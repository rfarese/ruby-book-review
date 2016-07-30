require 'rails_helper'

RSpec.feature "User deletes a book;", type: :feature do
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

  scenario "An authenticated user successfully deletes a rank they'd created for a book", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = User.where(id: rank.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Delete Rank"

    expect(page).to have_content("You've successfully deleted your book ranking")
    expect(Rank.all.size).to eq(0)
  end


  scenario "An unauthenticated user doesn't see the link to delete a rank", js: true do
    unauth_navigate_to_book_details_page

    expect(page).to_not have_content("Delete Rank")
  end

  scenario "An authenticated user doesn't see the link to delete a rank if they haven't created a rank for that book", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title

    expect(page).to_not have_content("Delete Rank")
  end
end
