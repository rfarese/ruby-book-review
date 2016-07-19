require 'rails_helper'

RSpec.feature "User views the list of books automatically updating;", type: :feature do

  # Acceptance Criteria:
  # * The functionality is implemented using an API endpoint and will render new data via JSON with React
  # * React component captures the data when initially rendered and redelivers the data every 5 seconds (thereby updating the books index page every 5 seconds)
  # * With 2 pages open (one on the books index page and the other on books new page), after the user creates the book, the books index page will update automatically with the new book

  context "On the books index page and without User #1 refreshing the page" do
    scenario "User #1 views the list of books automatically update when User #2 creates a new book", js: true do
      user = FactoryGirl.create(:user)
      sign_in(user)
      book = FactoryGirl.create(:book)

      expect(page).to have_content(book.title)
    end
  end
end
