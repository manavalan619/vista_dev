class AddArchivedAtToRequestTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :member_request_types, :archived_at, :datetime
  end
end
