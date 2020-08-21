class ChangeNotificationsResponseTextToJson < ActiveRecord::Migration[5.2]
  def up
    change_column :notifications, :response, :jsonb, using: 'response::jsonb'
  end

  def down
    change_column :notifications, :response, :text
  end
end
