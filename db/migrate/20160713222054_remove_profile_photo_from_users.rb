class RemoveProfilePhotoFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :profile_photo
  end

  def down
    add_column :users, :profile_photo 
  end
end
