class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :vista_member_id

      t.timestamps
    end

    add_column :users, :subject_id, :integer
    add_column :users, :subject_type, :string

    add_index :users,   [:subject_id, :subject_type], unique: true
    add_index :members, [:first_name, :last_name], unique: true
    add_index :members, :vista_member_id, unique: true
  end
end
