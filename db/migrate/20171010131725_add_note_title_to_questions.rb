class AddNoteTitleToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :note_title, :string
  end
end
