class AddArchivedAtToStaffMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :archived_at, :datetime
    add_index :staff_members, :archived_at
  end
end
