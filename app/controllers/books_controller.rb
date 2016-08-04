class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page])
  end

  def search
    @books = Book.where("title LIKE ?", params[:search]).page(params[:page])
  end

  def has_user_ranked_book?
    if Rank.where(book_id: params[:id], user_id: current_user.id).size != 0
      return @rank = Rank.where(book_id: params[:id], user_id: current_user.id).first
    end
  end

  def set_cover_photo(book)
    if Rails.env.test?
      @cover_photo = book.cover_photo.book_show.path
    else
      @cover_photo = book.cover_photo.book_show.url
    end
  end

  def show
    if user_signed_in?
      has_user_ranked_book?
    end
    @book = Book.find(params[:id])
    @reviews = @book.reviews.page(params[:page])
    @best_review = @book.best_review if @book.has_reviews? && @book.best_review.has_votes?
    set_cover_photo(@book)
  end

  def new
    @book = Book.new
  end

  def save_book(book)
    @book = book

    if @book.save
      flash[:notice] = "You've successfully created a new book!"
      redirect_to book_path(@book)
    else
      render "new"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    if user_signed_in?
      book = Book.new(book_params)
      save_book(book)
    else
      @book = Book.new
      flash[:notice] = "You must be signed in to create a new book"
      render "new"
    end
  end

  def does_book_update?(book)
    if book.update(book_params)
      flash[:notice] = "You've successfully updated your book!"
      redirect_to book
    else
      render 'edit'
    end
  end

  def do_user_ids_match?(book)
    if current_user.id == book.user_id
      does_book_update?(book)
    else
      flash[:notice] = "You can only edit a book you've created."
      render 'edit'
    end
  end

  def update
    @book = Book.find(params[:id])
    if user_signed_in?
      do_user_ids_match?(@book)
    else
      flash[:notice] = "You must be signed in to edit a book"
      render "edit"
    end
  end

  def user_id_matcher_for_delete(book)
    if current_user.id == book.user_id || admin?
      book.destroy
      flash[:notice] = "You've successfully deleted the book"
    else
      flash[:notice] = "You can only delete a book you've created"
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if user_signed_in?
      user_id_matcher_for_delete(@book)
    else
      flash[:notice] = "You must be signed in to delete a book"
    end
    redirect_to books_path
  end

  private
    def book_params
      params_hash = params.require(:book).permit(:title, :author, :description, :cover_photo)
      new_hash = { user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
