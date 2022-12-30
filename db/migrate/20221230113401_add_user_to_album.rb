class AddUserToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_reference :albums, :user
  end
end
