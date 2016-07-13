class ChangeBookCoverPhoto < ActiveRecord::Migration
  def change
    rename_column :books, :book_cover_photo, :cover_photo
  end
end
