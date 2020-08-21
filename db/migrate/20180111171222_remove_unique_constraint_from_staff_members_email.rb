class RemoveUniqueConstraintFromStaffMembersEmail < ActiveRecord::Migration[5.1]
  def up
    remove_index :staff_members, :email
    add_index :staff_members, :email, unique: false
  end

  def down
    remove_index :staff_members, :email
    add_index :staff_members, :email, unique: true
  end
end
