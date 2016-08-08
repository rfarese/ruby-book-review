require 'rails_helper'

RSpec.feature "Admin deletes a review;", type: :feature do

  scenario 'Admin successfully deletes a review created by a different user', js: true do
    admin = FactoryGirl.create(:admin)
    review = FactoryGirl.create(:review)
    book = Book.where(id: review.book_id).first
    sign_in(admin)
    find('img.book').click
    click_link "Edit"
    click_link "Delete Review"

    expect(page).to have_content("You've successfully deleted the review")
    expect(review.user_id).to_not eq(admin.id)
  end
end
