class AddNoteToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :note, :text
  end
end
