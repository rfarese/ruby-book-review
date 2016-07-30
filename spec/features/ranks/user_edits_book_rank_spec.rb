require 'rails_helper'

RSpec.feature "User edits a book rank;", type: :feature do
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

  scenario "Authenticated user views link to edit a rank they have created on the book show page", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = User.where(id: rank.user_id).first
    sign_in(user)
    click_link book.title

    expect(page).to have_content("Edit Rank")
  end

  scenario "Authenticated user successfully edits the book ranking", js: true do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = User.where(id: rank.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Edit Rank"
    choose('rank_score_3')
    click_button "Save Rank"
    edited_rank = Rank.where(id: rank.id).first

    expect(edited_rank.score).to eq(3)
  end
end
