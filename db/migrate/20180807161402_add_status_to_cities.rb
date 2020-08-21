class AddStatusToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :status, :string
    add_index :cities, :status
  end
end
