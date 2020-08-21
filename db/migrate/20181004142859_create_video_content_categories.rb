class CreateVideoContentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :video_content_categories do |t|
      t.references :video
      t.references :content_category
      t.timestamps
    end
  end
end
