class ChangeStaffAssignmentForeignKey < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :staff_assignments, column: :staff_member_id
    add_foreign_key :staff_assignments, :staff_members
  end
end
