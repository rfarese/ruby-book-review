require 'rails_helper'

RSpec.feature "User ranks a book;", type: :feature do

  scenario "User views ranking capabilities on the book show page" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title

    expect(page).to have_content("Rank This Book")
  end

  scenario "user views possible rankings for a book (1, 2, 3, 4, 5)" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title
    click_link "Rank This Book"

    expect(page).to have_content("Rank #{book.title}")
  end

  scenario "An authenticated user successfully ranks a book" do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.create(:book)
    sign_in(user)
    click_link book.title
    click_link "Rank This Book"
    choose("5")
    click_button "Save Rank"

    expect(page).to have_content("Your book ranking has been saved!")
    expect(Rank.all.size).to eq(1)
  end

  scenario "An unauthenticated user unsuccessfully attempts to rank a book" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title
    click_link "Rank This Book"
    choose("5")
    click_button "Save Rank"

    expect(page).to have_content("You must be signed in to rank a book")
    expect(Rank.all.size).to eq(0)
  end
end
