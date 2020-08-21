class AddViaToShares < ActiveRecord::Migration[5.1]
  def change
    add_column :shares, :via, :string
    add_index :shares, :via
  end
end
