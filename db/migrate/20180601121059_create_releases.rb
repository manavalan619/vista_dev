class CreateReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :releases do |t|
      t.string :file
      t.string :status, default: 'queued'

      t.timestamps
    end
  end
end
