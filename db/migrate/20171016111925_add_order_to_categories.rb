class AddOrderToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :position, :integer, default: 0, null: false
    add_index :categories, %i[ancestry position]
    add_column :categories, :initial, :boolean, default: false
  end
end
