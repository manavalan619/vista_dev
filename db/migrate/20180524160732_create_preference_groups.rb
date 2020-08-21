class CreatePreferenceGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :preference_groups do |t|
      t.string :title
      t.integer :question_ids, array: true, default: []

      t.timestamps
    end

    add_index :preference_groups, :question_ids, using: 'gin'
  end
end
