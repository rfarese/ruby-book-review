class ChangeRankColumnNameinRanks < ActiveRecord::Migration
  def change
    rename_column :ranks, :rank, :score
  end
end
