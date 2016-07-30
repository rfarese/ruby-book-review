require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should have_valid(:review_id).when(1, 2, 3, 4) }
  it { should have_valid(:user_id).when(1, 2, 3, 4) }

  it { should have_valid(:up_vote).when(true, false) }
  it { should_not have_valid(:up_vote).when(nil) }

  it { should have_valid(:down_vote).when(true, false) }
  it { should_not have_valid(:down_vote).when(nil) }

  it "can not have multiple votes by the same user for the same review" do
    first_vote = Vote.create(review_id: 1, user_id: 1, up_vote: true, down_vote: false)
    second_vote = Vote.create(review_id: 1, user_id: 1, up_vote: true, down_vote: false)
    third_vote = Vote.create(review_id: 1, user_id: 1, up_vote: false, down_vote: true)

    total_user_votes = Vote.where(user_id: 1)
    expect(total_user_votes.size).to eq(1)
  end
end
