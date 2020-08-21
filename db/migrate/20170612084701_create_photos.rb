class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :image

      t.timestamps
    end

    add_index :photos, [:owner_id, :owner_type], unique: true
  end
end
