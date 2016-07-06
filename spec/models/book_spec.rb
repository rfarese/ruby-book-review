require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_valid(:title).when("Some Book Title", "Book Title Stuff") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:author).when("Mark Smith", "Bobby LastName")}
  it { should_not have_valid(:author).when(nil, "") }

  it { should have_valid(:description).when("This is a description and it is a really good one at that.") }
  it { should_not have_valid(:description).when(nil, "") }

  it { should have_valid(:book_cover_photo).when(nil, "", "http://www.someurl.com") }

  describe "#rankings" do
    it "returns an array of rank objects" do
      rank = FactoryGirl.create(:rank, rank: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.rankings.size).to eq(3)
      expect(book.rankings.first).to be_instance_of(Rank)
    end
  end

  describe "#num_of_rankings" do
    it "gives the total number of rankings for the book" do
      rank = FactoryGirl.create(:rank, rank: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.num_of_rankings).to eq(3)
    end
  end

  describe "#rankings_sum" do
    it "gives the sum of all the rankings" do
      rank = FactoryGirl.create(:rank, rank: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.rankings_sum).to eq(4)
    end
  end

  describe "#average_rank" do
    it "gives the average rank of all the rankings" do
      rank = FactoryGirl.create(:rank, rank: 1)
      second_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 2)
      third_rank = FactoryGirl.create(:rank, book_id: rank.book_id, rank: 1)
      book = Book.where(id: rank.book_id).first

      expect(book.average_rank).to eq(1.3)
    end
  end
end
