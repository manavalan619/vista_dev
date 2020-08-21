class AddSuspendedAtToStaffMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :suspended_at, :datetime
    add_index :staff_members, :suspended_at
  end
end
