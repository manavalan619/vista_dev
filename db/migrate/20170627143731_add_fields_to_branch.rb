class AddFieldsToBranch < ActiveRecord::Migration[5.1]
  def change
    add_column :branches, :email, :string
    add_column :branches, :address, :text
    add_column :branches, :telephone, :string
  end
end
