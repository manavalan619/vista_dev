class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :staff_member, foreign_key: true
      t.belongs_to :branch, foreign_key: true, null: false
      t.belongs_to :category, foreign_key: true, null: false
      t.string :kind, null: false
      t.text :description

      t.timestamps
    end
  end
end
