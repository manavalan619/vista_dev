class CreateRolePreferenceGroupAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :role_preference_group_assignments do |t|
      t.belongs_to :role, foreign_key: true
      t.belongs_to :preference_group, foreign_key: true
      t.integer :position
      t.string :column

      t.timestamps
    end
  end
end
