class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :branch, foreign_key: true
      t.date :date
      t.time :arrival_time_start
      t.time :arrival_time_end

      t.timestamps
    end
  end
end
