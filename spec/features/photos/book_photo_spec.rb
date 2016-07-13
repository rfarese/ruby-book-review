require 'rails_helper'

RSpec.feature "User uploads a book cover photo;", type: :feature do

  scenario "User successfully uploads a book cover photo" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link "Add a New Book"
    fill_in "Title", with: "Practical Object Oriented Design in Ruby"
    fill_in "Author", with: "Sandy Metz"
    fill_in "Description", with: "This is a book about creating flexible software to ensure maintainability"
    attach_file :book_cover_photo, "#{Rails.root}/spec/support/images/POODIR_cover_photo.jpeg"
    click_button "Submit Book"
    book = Book.all.first

    expect(page).to have_content("Practical Object Oriented Design in Ruby")
    expect(page).to have_css("img[src*='#{book.cover_photo.path}']")
  end

  scenario "User doesn't view a photo if one isn't uploaded" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link "Add a New Book"
    fill_in "Title", with: "Practical Object Oriented Design in Ruby"
    fill_in "Author", with: "Sandy Metz"
    fill_in "Description", with: "This is a book about creating flexible software to ensure maintainability"
    click_button "Submit Book"
    book = Book.all.first

    expect(page).to have_content("Practical Object Oriented Design in Ruby")
    expect(page).to_not have_css("img[src*='#{book.cover_photo.path}']")
  end
end
