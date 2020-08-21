class AddBranchToStaffMember < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :branch_id, :integer
  end
end
