class RemoveBranchIdFromStaffMember < ActiveRecord::Migration[5.1]
  def change
    remove_column :staff_members, :branch_id, :integer
  end
end
