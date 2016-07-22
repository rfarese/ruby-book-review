require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_valid(:title).when("Some Review Title", "Review Title Stuff") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:description).when("This is a description for a review for a book and it is a valid one believe it or not.") }
  it { should_not have_valid(:description).when(nil, "") }

  describe "#up_votes" do
    it "returns the number of times the review has been up voted" do
      review = FactoryGirl.create(:review)
      vote = FactoryGirl.create(:vote, review_id: review.id)
      second_vote = FactoryGirl.create(:vote, review_id: review.id)

      expect(review.up_votes).to eq(2)
    end
  end

  describe "#down_votes" do
    it "returns the number of times the review has been down voted" do
      review = FactoryGirl.create(:review)
      vote = FactoryGirl.create(:vote, review_id: review.id, up_vote: false, down_vote: true)
      second_vote = FactoryGirl.create(:vote, review_id: review.id, up_vote: false, down_vote: true)

      expect(review.down_votes).to eq(2)
    end
  end

  describe "#score" do
    it "scores the review by subtracting the total down_votes from total up_votes" do
      review = FactoryGirl.create(:review)
      vote = FactoryGirl.create(:vote, review_id: review.id)
      second_vote = FactoryGirl.create(:vote, review_id: review.id, up_vote: false, down_vote: true)
      third_vote = FactoryGirl.create(:vote, review_id: review.id)
      fouth_vote = FactoryGirl.create(:vote, review_id: review.id)

      expect(review.score).to eq(2)
    end
  end

  describe "#has_votes?" do
    it "returns true if the review has been voted on" do
      review = FactoryGirl.create(:review)
      vote = FactoryGirl.create(:vote, review_id: review.id)

      expect(review.has_votes?).to eq(true)
    end

    it "returns false if the review has not been voted on" do
      review = FactoryGirl.create(:review)

      expect(review.has_votes?).to eq(false)
    end
  end

  describe "#build_tweet" do
    it "Creates the text for the body of a tweet" do
      review = FactoryGirl.create(:review)
      book = Book.where(id: review.book_id).first

      expect(review.build_tweet).to eq("Checkout my book review on #{book.title}!")
    end
  end

  describe "#send_tweet", js: true do
    it "sends a message to Twitter" do
      book = FactoryGirl.create(:book)
      twitter_user = create_twitter_user
      review = FactoryGirl.create(:review, user_id: twitter_user.id)
      tweet = review.send_tweet

      expect(tweet.full_text).to eq(review.build_tweet)
    end
  end
end
