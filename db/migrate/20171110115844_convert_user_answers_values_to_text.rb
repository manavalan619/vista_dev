class ConvertUserAnswersValuesToText < ActiveRecord::Migration[5.1]
  def change
    change_column :user_answers, :values, :text
  end
end
