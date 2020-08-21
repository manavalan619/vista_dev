class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.datetime :publish_at

      t.timestamps
    end

    add_index :articles, :publish_at
  end
end
