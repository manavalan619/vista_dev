class ChangeQuestionTextStyleDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :questions, :text_style, from: 'light', to: 'dark'
  end
end
