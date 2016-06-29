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
      flash[:notice] = "You must be signed in to create a new book"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if current_user.id == @book.user_id
      @book.destroy
      flash[:notice] = "You've successfully deleted your book"

      redirect_to books_path
    else
      flash[:notice] = "You can only delete a book you've created"
      render "edit"
    end
  end

  private
    def book_params
      params_hash = params.require(:book).permit(:title, :author, :description, :book_cover_photo)
      new_hash = { user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
