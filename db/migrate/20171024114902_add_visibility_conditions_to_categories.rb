class AddVisibilityConditionsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :visibility_conditions, :jsonb, default: [], null: false
    remove_column :questions, :visibility_conditions, :jsonb, default: [], null: false
  end
end
