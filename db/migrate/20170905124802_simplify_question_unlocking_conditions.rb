class SimplifyQuestionUnlockingConditions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :lock_by, :json
    remove_column :questions, :unlock_by, :json
    remove_column :answers, :content, :json
    add_column :questions, :locking_question_id, :integer
    add_column :questions, :locking_values, :string
    add_column :answers, :values, :string

    add_index :questions, :locking_question_id
  end
end
