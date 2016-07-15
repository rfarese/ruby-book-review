require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_valid(:title).when("Some Book Title", "Book Title Stuff") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:author).when("Mark Smith", "Bobby LastName")}
  it { should_not have_valid(:author).when(nil, "") }

  it { should have_valid(:description).when("This is a description and it is a really good one at that.") }
  it { should_not have_valid(:description).when(nil, "") }

  it { should have_valid(:cover_photo).when(nil, "", "http://www.someurl.com") }

  describe "#rankings" do
    it "returns an array of rank objects" do
      rank = FactoryGirl.create(:rank, score: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.ranks.size).to eq(3)
      expect(book.ranks.first).to be_instance_of(Rank)
    end
  end

  describe "#num_of_rankings" do
    it "gives the total number of rankings for the book" do
      rank = FactoryGirl.create(:rank, score: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.num_of_rankings).to eq(3)
    end
  end

  describe "#rankings_sum" do
    it "gives the sum of all the rankings" do
      rank = FactoryGirl.create(:rank, score: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.rankings_sum).to eq(4)
    end
  end

  describe "#average_rank" do
    it "gives the average rank of all the rankings" do
      rank = FactoryGirl.create(:rank, score: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, score: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.average_rank).to eq(1.3)
    end
  end

  describe "#best_review" do
    it "finds the review with the most amount of up votes" do
      review = FactoryGirl.create(:review)
      book = review.book
      second_review = FactoryGirl.create(:review, book_id: review.book_id)
      third_review = FactoryGirl.create(:review, book_id: review.book_id)
      vote = FactoryGirl.create(:vote, review_id: review.id)
      second_vote = FactoryGirl.create(:vote, review_id: second_review.id)
      third_vote = FactoryGirl.create(:vote, review_id: second_review.id, up_vote: false, down_vote: true)
      fourth_vote = FactoryGirl.create(:vote, review_id: third_review.id)
      fifth_vote = FactoryGirl.create(:vote, review_id: third_review.id)
      sixth_vote = FactoryGirl.create(:vote, review_id: third_review.id, up_vote: false, down_vote: true)
      seventh_vote = FactoryGirl.create(:vote, review_id: third_review.id, up_vote: false, down_vote: true)

      expect(review.book).to eq(second_review.book)
      expect(second_review.book).to eq(third_review.book)
      expect(book.best_review).to eq(review)
    end
  end

  describe "#has_reviews?" do
    it "returns true if the book has any reviews" do
      book = FactoryGirl.create(:book)
      review = FactoryGirl.create(:review, book_id: book.id)

      expect(book.has_reviews?).to eq(true)
    end

    it "returns false if the book doesn't have any reviews" do
      book = FactoryGirl.create(:book)

      expect(book.has_reviews?).to eq(false)
    end
  end
end
