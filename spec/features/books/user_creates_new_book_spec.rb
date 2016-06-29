require 'rails_helper'

RSpec.feature "User creates a new book", type: :feature do

  def signed_in_user
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def add_a_new_book
    fill_in "Title", with: "Some Title"
    fill_in "Author", with: "Some Author"
    fill_in "Description", with: "This is some new description for testing purposes"
    fill_in "Book cover photo", with: "www.someurlforaphoto.com"
    click_button "Submit Book"
  end

  scenario "user navigates to the new book page" do
    visit root_path
    click_link "Add a New Book"

    expect(page).to have_content("Add a New Book")
    expect(page).to have_content("Title")
    expect(page).to have_content("Author")
    expect(page).to have_content("Description")
    expect(page).to have_content("Book cover photo")
  end

  scenario "an unauthenticated user can not create a new book" do
    visit root_path
    click_link "Add a New Book"

    add_a_new_book

    expect(page).to have_content("You must be signed in to create a new book")
  end

  scenario "authenticated user successfully creates a new book" do
    signed_in_user
    click_link "Add a New Book"

    add_a_new_book

    expect(page).to have_content("You've successfully created a new book!")
  end

  scenario "authenticated user doesnt provide valid and required information to create a new book" do
    signed_in_user
    click_link "Add a New Book"

    click_button "Submit Book"

    expect(page).to have_content("3 errors prohibited this book from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Author can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
