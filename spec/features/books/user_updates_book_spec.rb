require 'rails_helper'

RSpec.feature "User updates a book;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  def sign_in_as_book_creator_and_navigate
    book
    current_user = User.where(id: book.user_id).first
    sign_in(current_user)
    find('img.books-index').click

    click_link "Edit Book"
  end

  scenario "authenticated user views link to navigate to the edit book page", js: true do
    book
    sign_in(user)
    find('img.books-index').click


    expect(page).to have_content("Edit Book")
  end

  scenario "unauthenticated user is unable to navigate to the edit book page", js: true do
    book
    visit root_path
    find('img.books-index').click


    expect(page).to_not have_content("Edit Book")
  end

  scenario "authenticated user successfully updates a book they've created", js: true do
    sign_in_as_book_creator_and_navigate

    fill_in "Title", with: "Updated Title"
    fill_in "Author", with: "Updated Author"
    fill_in "Description", with: "Updated description of this updated book with an updated title and an updated author"
    click_button "Submit Book"

    expect(page).to have_content("You've successfully updated your book")
  end

  scenario "authenticated users id doesn't match the book's user id and receives an error message", js: true do
    book
    sign_in(user)
    find('img.books-index').click

    click_link "Edit Book"

    fill_in "Title", with: "Updated Title"
    fill_in "Author", with: "Updated Author"
    fill_in "Description", with: "Updated description of this updated book with an updated title and an updated author"
    click_button "Submit Book"

    expect(page).to have_content("You can only edit a book you've created")
  end

  scenario "authenticated user's id matches the book's user id but fails to provide valid and required information", js: true do
    sign_in_as_book_creator_and_navigate

    fill_in "Title", with: ""
    fill_in "Author", with: ""
    fill_in "Description", with: ""
    click_button "Submit Book"

    expect(page).to have_content("3 errors prohibited this book from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Author can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
