class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.belongs_to :user, foreign_key: true
      t.string :platform
      t.string :token

      t.timestamps
    end
    add_index :devices, :platform
    add_index :devices, :token
  end
end
