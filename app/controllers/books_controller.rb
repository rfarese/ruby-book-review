class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
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

  private
    def book_params
      params_hash = params.require(:book).permit(:title, :author, :description, :book_cover_photo)
      new_hash = { user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
