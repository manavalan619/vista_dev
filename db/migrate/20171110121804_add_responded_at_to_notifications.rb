class AddRespondedAtToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :responded_at, :datetime
  end
end
