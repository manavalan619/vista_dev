class ModifyVideoStructure < ActiveRecord::Migration[5.2]
  def change
    rename_column :videos, :publish_at, :published_at
    add_column :videos, :published, :boolean, default: false

    add_index :videos, :published
  end
end
