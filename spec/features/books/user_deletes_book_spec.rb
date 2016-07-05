require 'rails_helper'

RSpec.feature "User deletes a book", type: :feature do
  def create_user
    FactoryGirl.create(:user)
  end

  def create_book
    FactoryGirl.create(:book)
  end

  def sign_in_user(user)
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

#   Acceptance Criteria:
#     * If the current users id matches the book user id and clicks the delete book link, the book and all of its corresponding data (reviews, votes, and rankings) are deleted

  scenario "unauthenticated user can't access book edit page to view the delete functionality" do
    book = FactoryGirl.create(:book)
    visit root_path
    click_link book.title

    expect(page).to_not have_content("Edit Book")
  end

  scenario "authenticated user views delete link on the edit book page" do
    book = FactoryGirl.create(:book)
    sign_in_user(create_user)
    visit root_path
    click_link book.title
    click_link "Edit Book"

    expect(page).to have_content("Delete Book")
  end

  scenario "authenticated user's id doesn't match the book user id and fails to delete a book" do
    book = FactoryGirl.create(:book)
    sign_in_user(create_user)
    visit root_path
    click_link book.title
    click_link "Edit Book"
    click_link "Delete Book"

    expect(page).to have_content("You can only delete a book you've created")
  end

  scenario "authenticated user successfully deletes a book that they've created" do
    book = FactoryGirl.create(:book)
    user = User.where(id: book.user_id).first
    sign_in_user(user)
    visit root_path
    click_link book.title
    click_link "Edit Book"
    click_link "Delete Book"

    expect(page).to have_content("You've successfully deleted the book")
  end
end
