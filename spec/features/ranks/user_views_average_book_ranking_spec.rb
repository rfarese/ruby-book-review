require 'rails_helper'

RSpec.feature "User views average book rank;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }

  def unauth_navigate_to_book_details_page
    book
    visit root_path
    click_link book.title
  end

  scenario "An unauthenticated user views the average ranking on the book show page" do
    rank = FactoryGirl.create(:rank)
    unauth_navigate_to_book_details_page

    expect(page).to have_content("Average Ranking:")
  end

  scenario "An authenticated user views the average book ranking on the book show page" do
    rank = FactoryGirl.create(:rank)
    book = Book.where(id: rank.book_id).first
    user = FactoryGirl.create(:user)
    sign_in(user)
    click_link book.title

    expect(page).to have_content("Average Ranking: #{rank.rank}")
  end
end
