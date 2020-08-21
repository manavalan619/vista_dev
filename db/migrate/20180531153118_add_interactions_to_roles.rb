class AddInteractionsToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :interactions, :string, array: true
  end
end
