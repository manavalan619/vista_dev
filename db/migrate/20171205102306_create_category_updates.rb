class CreateCategoryUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :category_updates do |t|
      t.belongs_to :category, foreign_key: true
      t.integer :question_ids, array: true, default: []

      t.timestamps
    end

    add_index :category_updates, :question_ids, using: :gin
  end
end
