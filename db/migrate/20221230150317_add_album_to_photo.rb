class AddAlbumToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :album
  end
end
