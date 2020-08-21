class ChangeAnswersPositionDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :answers, :position, from: 1, to: 0
  end
end
