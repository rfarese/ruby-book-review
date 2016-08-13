require 'rails_helper'

RSpec.feature "Determine if a user has voted for a review;", type: :feature do

  scenario "User has already voted for a review" do
    vote = FactoryGirl.create(:vote)
    review = vote.review
    user = User.find(vote.user_id)
    sign_in(user)

    expect(review.has_user_voted?(user)).to eq(true)
  end

  scenario "User has not yet voted for a review" do
    review = FactoryGirl.create(:review)
    user = User.find(review.user_id)
    sign_in(user)

    expect(review.has_user_voted?(user)).to eq(false)
  end

  scenario "User has voted for current review and we retrieve that vote" do
    vote = FactoryGirl.create(:vote)
    review = vote.review
    user = User.find(vote.user_id)
    sign_in(user)
    user_vote = review.vote_by_current_user(user)

    expect(user_vote).to eq(vote)
  end
end
