class RenameAnswersToUserAnswers < ActiveRecord::Migration[5.1]
  def change
    rename_table :answers, :user_answers
  end
end
