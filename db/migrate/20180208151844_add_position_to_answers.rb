class AddPositionToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :position, :integer, default: 1
    add_index :answers, :position
  end
end
