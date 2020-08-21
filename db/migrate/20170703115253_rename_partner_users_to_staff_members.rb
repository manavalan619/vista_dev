class RenamePartnerUsersToStaffMembers < ActiveRecord::Migration[5.1]
  def change
    rename_table :partner_users, :staff_members
    rename_table :partner_assignments, :staff_assignments
    rename_column :staff_assignments, :partner_id, :staff_member_id
    remove_column :staff_members, :branch_id, :integer
  end
end
