class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.integer :rank, null: false, inclusion: 1..5
    end

    add_index :ranks, [:user_id, :book_id], unique: true
  end
end
