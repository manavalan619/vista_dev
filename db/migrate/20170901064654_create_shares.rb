class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.integer :branch_id
      t.integer :member_id

      t.timestamps
    end
  end
end
