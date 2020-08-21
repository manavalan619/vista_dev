class AddPhotoTypeToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_type, :string
    add_index :photos, :photo_type

    remove_index :photos, %i[owner_id owner_type]
    add_index :photos, %i[owner_id owner_type photo_type]
  end
end
