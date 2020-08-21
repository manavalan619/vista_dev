class AddIndexesToStaffAssignments < ActiveRecord::Migration[5.1]
  def change
    add_index :staff_assignments,
              %i[staff_member_id target_id target_type],
              name: 'index_staff_member_target_assignment'
    add_index :staff_assignments,
              %i[staff_member_id target_id target_type archived_at],
              name: 'index_unarchived_staff_member_target_assignment'
  end
end
