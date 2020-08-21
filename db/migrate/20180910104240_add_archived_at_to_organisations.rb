class AddArchivedAtToOrganisations < ActiveRecord::Migration[5.2]
  def change
    add_column :organisations, :archived_at, :datetime
  end
end
