class AddTypeToInteractions < ActiveRecord::Migration[5.1]
  def change
    add_column :interactions, :type, :string, null: false, default: ''
    add_index :interactions, :type

    change_column_null :interactions, :branch_id, true
    change_column_null :interactions, :category_id, true
  end
end
