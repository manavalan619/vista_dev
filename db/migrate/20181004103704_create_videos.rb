class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :url
      t.datetime :publish_at
      t.references :organisation
      t.references :vista_admin
      t.integer :notification_job_id
      t.timestamps
    end
  end
end
