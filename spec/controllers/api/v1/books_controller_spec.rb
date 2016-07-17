require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  describe "POST /api/v1/books" do
    include Devise::TestHelpers

    it "creates a new book" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      book = build(:book)
      post :create, book: book.attributes
      expect(response).to have_http_status(:created)
      expect(response.header["Location"]).to match /\/api\/v1\/books/
    end

    it "returns 'not_found' if validations fail" do
      user = FactoryGirl.create(:user)
      sign_in(user)
      post :create, book: { title: "", author: "", description: "" }
      expect(response).to have_http_status(:not_found)
    end
  end
end




























#
