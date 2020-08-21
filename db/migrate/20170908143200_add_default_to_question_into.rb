class AddDefaultToQuestionInto < ActiveRecord::Migration[5.1]
  def change
    change_column_default :questions, :intro, false
  end
end
