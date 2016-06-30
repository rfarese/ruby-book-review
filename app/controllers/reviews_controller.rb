class ReviewsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])

    if user_signed_in?
      @review = @book.reviews.create(review_params)
      flash[:notice] = "You've successfully added your new review!"
    else
      @review = Review.new
      flash[:notice] = "You must be signed in to create a book review"
    end
    redirect_to book_path(@book)
  end

  private
    def review_params
      params_hash = params.require(:review).permit(:title, :description)
      hash = { book_id: params[:book_id], user_id: current_user.id }
      new_hash = hash.merge!(params_hash)
    end
end
