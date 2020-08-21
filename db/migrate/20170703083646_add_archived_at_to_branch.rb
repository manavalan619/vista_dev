class AddArchivedAtToBranch < ActiveRecord::Migration[5.1]
  def change
    add_column :branches, :archived_at, :datetime
  end
end
