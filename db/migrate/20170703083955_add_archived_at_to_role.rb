class AddArchivedAtToRole < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :archived_at, :datetime
  end
end
