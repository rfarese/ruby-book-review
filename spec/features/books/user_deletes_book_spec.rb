require 'rails_helper'

RSpec.feature "User deletes a book", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

#   Acceptance Criteria:
#     * If the current users id matches the book user id and clicks the delete book link, the book and all of its corresponding data (reviews, votes, and rankings) are deleted

  scenario "unauthenticated user can't access book edit page to view the delete functionality" do
    book
    visit root_path
    click_link book.title

    expect(page).to_not have_content("Edit Book")
  end

  scenario "unauthenticated unsuccessfully attempts to delete a book" do
    book
    visit root_path
    click_link book.title
    Capybara.current_session.driver.delete book_path(book)
    visit books_path

    expect(page).to have_content("You must be signed in to delete a book")
    expect(Book.all.size).to eq(1)
  end

  scenario "authenticated user views delete link on the edit book page" do
    book
    sign_in(user)
    visit root_path
    click_link book.title
    click_link "Edit Book"

    expect(page).to have_content("Delete Book")
  end

  scenario "authenticated user's id doesn't match the book user id and fails to delete a book" do
    book
    sign_in(user)
    visit root_path
    click_link book.title
    click_link "Edit Book"
    click_link "Delete Book"

    expect(page).to have_content("You can only delete a book you've created")
  end

  scenario "authenticated user successfully deletes a book that they've created" do
    book
    current_user = User.where(id: book.user_id).first
    sign_in(current_user)
    visit root_path
    click_link book.title
    click_link "Edit Book"
    click_link "Delete Book"

    expect(page).to have_content("You've successfully deleted the book")
  end
end
