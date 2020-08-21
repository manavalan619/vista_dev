class DropMoods < ActiveRecord::Migration[5.1]
  def up
    drop_table :moods
  end

  def down
    create_table :moods do |t|
      t.belongs_to :user, foreign_key: true
      t.jsonb :values, default: [], null: false

      t.timestamps
    end
  end
end
