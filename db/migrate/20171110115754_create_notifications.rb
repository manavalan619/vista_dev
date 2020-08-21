class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, foreign_key: true
      t.string :type
      t.text :response
      t.references :object, polymorphic: true

      t.timestamps
    end
    add_index :notifications, :type
  end
end
