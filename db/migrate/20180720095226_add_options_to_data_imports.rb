class AddOptionsToDataImports < ActiveRecord::Migration[5.2]
  def change
    add_column :data_imports, :options, :jsonb, default: {}
  end
end
