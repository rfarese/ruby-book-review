class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])

    if user_signed_in?
      @review = @book.reviews.create(review_params)
      # ReviewMailer.new_review(@review).deliver_later if @review.valid?
      @review.send_tweet if @review.valid?
      flash[:notice] = "You've successfully added your new review!"
    else
      @review = Review.new
      flash[:notice] = "You must be signed in to create a book review"
    end
    redirect_to book_path(@book)
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
  end

  def does_review_update?(review, book)
    if review.update(review_params)
      flash[:notice] = "You've successfully updated your review!"
      redirect_to book_path(book)
    else
      render 'edit'
    end
  end

  def do_user_ids_match?(review, book)
    if current_user.id == review.user_id
      does_review_update?(review, book)
    else
      flash[:notice] = "You can only edit a review you've created."
      render 'edit'
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])

    if user_signed_in?
      do_user_ids_match?(@review, @book)
    else
      flash[:notice] = "You must be signed in to edit a review"
      render "edit"
    end
  end

  def user_id_matcher_for_delete(book, review)
    if current_user.id == review.user_id || admin?
      review.destroy
      flash[:notice] = "You've successfully deleted the review"
      redirect_to book_path(book)
    else
      flash[:notice] = "You can only delete a review you've created"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])

    if user_signed_in?
      user_id_matcher_for_delete(@book, @review)
    else
      flash[:notice] = "You must be signed in to delete a review"
      render "edit"
    end
  end

  private
    def review_params
      params_hash = params.require(:review).permit(:title, :description)
      hash = { book_id: params[:book_id], user_id: current_user.id }
      new_hash = hash.merge!(params_hash)
    end
end
