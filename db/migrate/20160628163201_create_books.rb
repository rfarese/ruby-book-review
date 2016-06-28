class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.text :description, null: false
      t.string :book_cover_photo
    end
  end
end
