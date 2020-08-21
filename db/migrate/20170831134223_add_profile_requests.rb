class AddProfileRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_requests do |t|
      t.integer :branch_id
      t.integer :member_id

      t.timestamps
    end

    add_index :profile_requests, [:branch_id, :member_id], unique: true
  end
end
