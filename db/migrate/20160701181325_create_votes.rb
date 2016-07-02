class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :review_id, null: false
      t.integer :user_id, null: false
      t.boolean :up_vote, null: false, default: false
      t.boolean :down_vote, null: false, default: false
    end

    add_index :votes, [:user_id, :review_id], unique: true
  end
end
