class RanksController < ApplicationController
  def new
    @rank = Rank.new
    @book = Book.where(id: params[:book_id]).first
  end

  def create
    @book = Book.where(id: params[:book_id]).first

    if user_signed_in?
      @rank = Rank.create(rank_params)
      flash[:notice] = "Your book ranking has been saved!"
    else
      @rank = Rank.new
      flash[:notice] = "You must be signed in to rank a book"
    end
    redirect_to book_path(@book)
  end

  private
    def rank_params
      params_hash = params.require(:rank).permit(:rank)
      new_hash = { book_id: params[:book_id], user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
