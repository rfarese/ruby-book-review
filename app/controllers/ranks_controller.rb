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

  def edit
    @book = Book.find(params[:book_id])
    @rank = Rank.find(params[:id])
  end

  def does_rank_update?(rank, book)
    if rank.update(rank_params)
      flash[:notice] = "You've successfully updated your rank!"
      redirect_to book
    else
      render 'edit'
    end
  end
  def do_user_ids_match?(rank, book)
    if current_user.id == rank.user_id
      does_rank_update?(rank, book)
    else
      flash[:notice] = "You can only edit a rank you've created."
      render 'edit'
    end
  end

  def update
    @book = Book.where(id: params[:book_id]).first
    @rank = Rank.where(id: params[:id]).first

    if user_signed_in?
      do_user_ids_match?(@rank, @book)
    else
      flash[:notice] = "You must be signed in to edit a book ranking"
      render 'edit'
    end
  end

  private
    def rank_params
      params_hash = params.require(:rank).permit(:rank)
      new_hash = { book_id: params[:book_id], user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
