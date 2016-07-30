require 'rails_helper'

RSpec.feature "User views the list of books automatically updating;", type: :feature do
  context "On the books index page and without User #1 refreshing the page" do
    scenario "User #1 views the list of books automatically update when User #2 creates a new book", js: true do
      user = FactoryGirl.create(:user)
      sign_in(user)
      book = FactoryGirl.create(:book)

      expect(page).to have_content(book.title)
    end
  end
end
