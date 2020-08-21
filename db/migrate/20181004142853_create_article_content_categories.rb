class CreateArticleContentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_content_categories do |t|
      t.references :article
      t.references :content_category
      t.timestamps
    end
  end
end
