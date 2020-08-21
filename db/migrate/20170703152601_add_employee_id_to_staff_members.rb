class AddEmployeeIdToStaffMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :employee_id, :string
    add_index :staff_members, :employee_id, unique: true
  end
end
