class AddArchivedAtToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :archived_at, :datetime
  end
end
