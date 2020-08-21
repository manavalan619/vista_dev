class AddStatusToShares < ActiveRecord::Migration[5.1]
  def change
    add_column :shares, :status, :string
    add_index :shares, :status
  end
end
