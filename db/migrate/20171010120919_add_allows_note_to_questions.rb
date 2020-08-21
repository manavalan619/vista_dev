class AddAllowsNoteToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :allows_note, :boolean, default: false
    add_index :questions, :allows_note
  end
end
