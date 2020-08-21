class AddMultipleQuestionsDependency < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :locking_question_id, :integer
    remove_column :questions, :locking_values, :string
    add_column :questions, :locking_conditions, :json, default: {}.to_json
  end
end
