class DropMembers < ActiveRecord::Migration[5.1]
  def change
    drop_table :members
  end
end
