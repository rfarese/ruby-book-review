require 'rails_helper'

RSpec.feature "Admin deletes a book", type: :feature do

  scenario 'Admin successfully deletes a book created by a different user' do
    admin = FactoryGirl.create(:admin)
    book = FactoryGirl.create(:book)
    sign_in(admin)
    click_link book.title
    click_link "Edit Book"
    click_link "Delete Book"

    expect(page).to have_content("You've successfully deleted the book")
  end
end
