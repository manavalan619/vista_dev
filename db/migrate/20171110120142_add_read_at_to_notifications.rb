class AddReadAtToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :read_at, :datetime
    add_index :notifications, :read_at
  end
end
