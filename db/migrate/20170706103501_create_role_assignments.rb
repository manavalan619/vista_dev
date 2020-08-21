class CreateRoleAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :role_assignments do |t|
      t.references :role, foreign_key: true
      t.references :staff_member, foreign_key: true
      t.datetime :archived_at

      t.timestamps
    end
    add_index :role_assignments, :archived_at
    add_index :role_assignments, %i[role_id staff_member_id archived_at],
              name: 'index_unarchived_staff_member_role'
  end
end
