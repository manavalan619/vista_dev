class RenameNameFieldsToTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :name, :title
    rename_column :questions, :name, :title
  end
end
