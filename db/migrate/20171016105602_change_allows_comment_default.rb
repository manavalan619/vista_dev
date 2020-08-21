class ChangeAllowsCommentDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :questions, :allows_note, true
  end
end
