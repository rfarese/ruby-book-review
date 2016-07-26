require 'rails_helper'

RSpec.feature "User posts a review to Twitter", type: :feature do

# Acceptance Criteria:
# * User successfully adds a book review to their Twitter account

  scenario "User successfully adds a book review to their Twitter account", js: true do
    book = FactoryGirl.create(:book)
    twitter_user = create_twitter_user
    sign_in_twitter_user(twitter_user)
    click_link book.title
    fill_in "Title", with: "I love POODR!"
    fill_in "Description", with: "Sandi gave us one hell of a 'gem'...when she wrote POODR!"
    click_button "Submit Review"
    review = Review.where(title: "I love POODR!").first

    expect(review.send_tweet.full_text).to eq(review.build_tweet)
  end
end
