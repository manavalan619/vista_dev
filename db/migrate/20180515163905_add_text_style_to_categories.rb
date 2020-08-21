class AddTextStyleToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :text_style, :string, default: 'dark'
  end
end
