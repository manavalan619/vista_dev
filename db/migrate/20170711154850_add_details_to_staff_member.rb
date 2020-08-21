class AddDetailsToStaffMember < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :pin, :integer
  end
end
