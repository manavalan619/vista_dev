class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.belongs_to :branch, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :value

      t.timestamps
    end

    add_column :branches, :ratings_count, :integer, default: 0
  end
end
