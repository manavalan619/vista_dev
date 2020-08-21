class ConvertStaffMembersPinToEncryptedString < ActiveRecord::Migration[5.1]
  def up
    change_column :staff_members, :pin, :string
    rename_column :staff_members, :pin, :encrypted_pin
  end

  def down
    rename_column :staff_members, :encrypted, :pin
    change_column :staff_members, :pin, :integer
  end
end
