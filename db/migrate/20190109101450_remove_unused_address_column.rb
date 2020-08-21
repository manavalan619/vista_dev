class RemoveUnusedAddressColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :branches, :address
  end
end
