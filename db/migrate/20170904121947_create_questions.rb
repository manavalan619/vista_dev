class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :category_id
      t.string :name
      t.string :kind
      t.json :possible_answers
      t.json :lock_by
      t.json :unlock_by

      t.timestamps
    end

    add_index :questions, :category_id
    add_index :questions, :kind
  end
end
