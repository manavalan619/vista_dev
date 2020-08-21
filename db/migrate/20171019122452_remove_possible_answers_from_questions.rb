class RemovePossibleAnswersFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :possible_answers
  end
end
