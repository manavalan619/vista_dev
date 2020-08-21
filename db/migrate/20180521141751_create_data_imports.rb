class CreateDataImports < ActiveRecord::Migration[5.2]
  def change
    create_table :data_imports do |t|
      t.string :file
      t.string :status, default: 'new'
      t.text :log
      t.datetime :finished_at

      t.timestamps
    end
  end
end
