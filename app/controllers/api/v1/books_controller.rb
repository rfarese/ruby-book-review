class Api::V1::BooksController < Api::V1::ApiController

  def index
    render json: Book.all
  end

  def save_book(book)
    if book.save
      message = "You've successfully created a new book!"
      render json: message, status: :created, location: api_v1_books_path(book)
    else
      render json: :nothing, status: :not_found
    end
  end

  def create
    if user_signed_in?
      book = Book.new(book_params)
      save_book(book)
    else
      book = Book.new
      message = "You must be signed in to create a new book"
      render json: message
    end
  end

  private
    def book_params
      params_hash = params.require(:book).permit(:title, :author, :description, :cover_photo)
      new_hash = { user_id: current_user.id }
      new_hash.merge!(params_hash)
    end
end
