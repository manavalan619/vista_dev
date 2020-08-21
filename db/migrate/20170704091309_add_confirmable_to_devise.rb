class AddConfirmableToDevise < ActiveRecord::Migration[5.1]
  def up
    add_column :staff_members, :confirmation_token, :string
    add_column :staff_members, :confirmed_at, :datetime
    add_column :staff_members, :confirmation_sent_at, :datetime
    add_index :staff_members, :confirmation_token, unique: true
    execute('UPDATE staff_members SET confirmed_at = NOW()')
  end

  def down
    remove_columns :staff_members, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
