class AddNotificationJobIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :notification_job_id, :integer
  end
end
