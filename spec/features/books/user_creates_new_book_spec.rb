require 'rails_helper'

RSpec.feature "User creates a new book;", type: :feature do

  let(:user) { FactoryGirl.create(:user) }

  def add_a_new_book
    fill_in "Title", with: "Some Title"
    fill_in "Author", with: "Some Author"
    fill_in "Description", with: "This is some new description for testing purposes"
    click_button "Submit Book"
  end

  scenario "user navigates to the new book page" do
    visit root_path
    first(:link, "Add Book").click

    expect(page).to have_content("Add a New Book")
    expect(page).to have_content("Title")
    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
  end

  scenario "an unauthenticated user can not create a new book" do
    visit root_path
    first(:link, "Add Book").click

    add_a_new_book

    expect(page).to have_content("You must be signed in to create a new book")
  end

  scenario "authenticated user successfully creates a new book" do
    sign_in(user)
    first(:link, "Add Book").click
    add_a_new_book

    expect(page).to have_content("You've successfully created a new book!")
  end

  scenario "authenticated user doesnt provide valid and required information to create a new book" do
    sign_in(user)
    first(:link, "Add Book").click
    click_button "Submit Book"

    expect(page).to have_content("3 errors prohibited this book from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Author can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
