class VotesController < ApplicationController

  def has_user_voted(review)
    voting_status = "None"
    if user_signed_in? && Vote.where(user_id: current_user.id, review_id: review.id).first
      @vote = Vote.where(user_id: current_user.id, review_id: review.id).first
      if @vote.up_vote == true
        voting_status = "Up Voted"
      end
      if @vote.down_vote == true
        voting_status = "Down Voted"
      end
    end
    voting_status
  end

  def new
    @review = Review.where(id: params[:review_id]).first
    @vote = Vote.new(review_id: @review.id)
    @voting_status = has_user_voted(@review)
  end

  def do_user_ids_match?(review, book)
    if current_user.id != review.user_id
      @vote = Vote.create(vote_params)
      flash[:notice] = "What a Nice Looking Vote!"
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
      flash[:notice] = "Join the cool kids! Sign in to cast your vote!"
    end
    @voting_status = has_user_voted(@review)
    render "new"
  end

  def do_user_ids_match_update?(review, vote)
    if current_user.id != review.user_id
      vote.update(vote_params)
      flash[:notice] = "You've successfully updated your vote"
    else
      flash[:notice] = "You can't vote for your own review"
    end
  end

  def update
    @review = Review.find(params[:review_id])
    @book = Book.where(id: @review.book_id).first

    if user_signed_in?
      @vote = Vote.where(user_id: current_user.id, review_id: params[:review_id]).first
      do_user_ids_match_update?(@review, @vote)
    else
      flash[:notice] = "You must be signed in to vote"
    end
    redirect_to new_review_vote_path(@review)
  end


  def do_user_ids_match_destroy(review, vote)
    if current_user.id == vote.user_id
      vote.destroy
      flash[:notice] = "Vote deleted"
    else
      flash[:notice] = "You can not delete someone elses vote"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    if user_signed_in?
      @vote = Vote.where(id: params[:id]).first
      do_user_ids_match_destroy(@review, @vote)
    else
      flash[:notice] = "You must be signed in to delete a vote"
    end
    redirect_to new_review_vote_path(@review)
  end

  private
  def vote_params
    { review_id: params[:review_id], user_id: current_user.id, up_vote: params[:up_vote], down_vote: params[:down_vote] }
  end
end
