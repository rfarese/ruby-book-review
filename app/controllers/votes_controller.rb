class VotesController < ApplicationController

  def do_user_ids_match?(review, book)
    if current_user.id != review.user_id
      @vote = Vote.create(vote_params)
      flash[:notice] = "Nice Up Vote!"
    else
      flash[:notice] = "You can't vote for your own review"
    end
  end

  def create
    @review = Review.find(params[:review_id])
    @book = Book.where(id: @review.book_id).first

    if user_signed_in?
      do_user_ids_match?(@review, @book)
    else
      flash[:notice] = "Sign in before you vote!"
    end
    redirect_to book_path(@book)
  end

  private
  def vote_params
    { review_id: params[:review_id], user_id: current_user.id, up_vote: params[:up_vote], down_vote: params[:down_vote] }
  end
end
