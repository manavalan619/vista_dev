class ChangeStaffMemberIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :staff_members, :employee_id
    add_index :staff_members, [:employee_id, :organisation_id], unique: true
  end
end
