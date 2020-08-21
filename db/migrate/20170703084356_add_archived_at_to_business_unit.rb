class AddArchivedAtToBusinessUnit < ActiveRecord::Migration[5.1]
  def change
    add_column :business_units, :archived_at, :datetime
  end
end
