require 'rails_helper'

RSpec.feature "User recieves a 'new review' email alert;", type: :feature do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  def navigate_and_fill_in_review
    find('img.book').click

    fill_in "Title", with: "This is a wonderful book!"
    fill_in "Description", with: "Even though its a little lengthy at times, the ending is awesome!"
    click_button "Submit Review"
  end

  scenario "book creator recieves an email alert when an authenticated user successfully creates a review", js: true do
    book
    book_creator = book.user
    sign_in(user)
    navigate_and_fill_in_review

    expect(page).to have_content("You've successfully added your new review!")
    expect(Review.all.size).to eq(1)
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    last_email = ActionMailer::Base.deliveries.last
  end
end
