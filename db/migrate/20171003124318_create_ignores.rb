class CreateIgnores < ActiveRecord::Migration[5.1]
  def change
    create_table :ignores do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
