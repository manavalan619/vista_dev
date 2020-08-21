class AddUncomfirmedEmailToStaffMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :staff_members, :unconfirmed_email, :string
  end
end
