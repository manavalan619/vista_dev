class AddPlatformIdToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :platform_id, :string
  end
end
