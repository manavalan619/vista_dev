class AddContentCategoryIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :article_content_categories, %i[content_category_id article_id], name: 'index_article_categories'
    add_index :video_content_categories, %i[content_category_id video_id], name: 'index_video_categories'
  end
end
