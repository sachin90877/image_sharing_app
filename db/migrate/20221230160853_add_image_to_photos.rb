class AddImageToPhotos < ActiveRecord::Migration[6.0]
  def change
    change_table :photos do |t|
      t.attachment :image
    end
  end
end