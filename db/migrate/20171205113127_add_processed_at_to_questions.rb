class AddProcessedAtToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :processed_at, :datetime
    add_index :questions, :processed_at
  end
end
