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

  scenario "Authenticated user views link to edit the book rank on the book show page" do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = User.where(id: rank.user_id).first
    sign_in(user)
    click_link book.title

    expect(page).to have_content("Edit Rank")
  end

  scenario "Authenticated user successfully edits the book ranking" do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = User.where(id: rank.user_id).first
    sign_in(user)
    click_link book.title
    click_link "Edit Rank"
    choose('rank_rank_3')
    click_button "Save Rank"
    edited_rank = Rank.where(id: rank.id).first

    expect(edited_rank.rank).to eq(3)
  end

  scenario "Unauthenticated user unsuccessfully attempts to edit a book rank" do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    visit root_path
    click_link book.title
    click_link "Edit Rank"
    choose('rank_rank_3')
    click_button "Save Rank"

    expect(page).to have_content("You must be signed in to edit a book ranking")
  end

  scenario "Authenticated user unsuccessfully attempts to edit a book rank that they did not create" do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title
    click_link "Edit Rank"
    choose('rank_rank_3')
    click_button "Save Rank"

    expect(page).to have_content("You can only edit a rank you've created")
  end
end