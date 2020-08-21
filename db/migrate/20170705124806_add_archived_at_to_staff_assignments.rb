class AddArchivedAtToStaffAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_assignments, :archived_at, :datetime
    add_index :staff_assignments, :archived_at
  end
end
